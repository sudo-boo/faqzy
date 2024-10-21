import numpy as np
import pandas as pd
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import json


# Load and transform the JSON data into a suitable pandas DataFrame format
with open('faqs.json', 'r') as f:
    data = json.load(f)

# Convert JSON structure to DataFrame with 'category', 'question', and 'answer' fields
data_list = []
for category, qna_list in data.items():
    for item in qna_list:
        data_list.append({
            'category': category,
            'question': item['question'],
            'answer': item['answer']
        })

df_col = pd.DataFrame(data_list)

# Load the Sentence Transformer model
model = SentenceTransformer("all-MiniLM-L6-v2")

# Precompute embeddings for all the questions
sentences = df_col['question'].tolist()
embeddings = model.encode(sentences)

@api_view(['POST'])
def get_answer(request):
    # Check if a query was provided
    query = request.data.get('query')
    
    if not query:
        return Response({'error': 'Query not provided'}, status=status.HTTP_400_BAD_REQUEST)

    try:
        # Encode the query
        query_embedding = model.encode([query])

        # Compute cosine similarities
        similarities = cosine_similarity(embeddings, query_embedding)
      
        similar_questions = []
        
        for idx, simi in enumerate(similarities):
            # if simi > 0.5:
            similar_questions.append({
                    'category': df_col['category'][idx],
                    'question': df_col['question'][idx],
                    'answer': df_col['answer'][idx],
                    'similarity_score': float(simi[0])  # Convert numpy float to standard float
            })

        
        similar_questions = sorted(similar_questions, key=lambda x: x['similarity_score'], reverse=True)
        similar_questions = similar_questions[:5]


        # Prepare response data
        response_data = {
            'top_5_questions': similar_questions
        }

        return Response(response_data)

    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    


@api_view(['POST'])
def add_query(request):
    try:
        # Extract category, question, and answer from the request
        category = request.data.get('category')
        question = request.data.get('question')
        answer = request.data.get('answer')

        # Validate that all fields are provided
        if not category or not question or not answer:
            return Response({'error': 'Category, question, and answer must all be provided'}, status=status.HTTP_400_BAD_REQUEST)

        # Load the current FAQ data from the JSON file
        with open('faqs.json', 'r') as f:
            data = json.load(f)

        # If the category does not exist, create a new category list
        if category not in data:
            data[category] = []

        # Add the new question and answer to the corresponding category
        data[category].append({
            'question': question,
            'answer': answer
        })

        # Save the updated data back to the JSON file
        with open('faqs.json', 'w') as f:
            json.dump(data, f, indent=4)

        # Also update the DataFrame with the new entry
        global df_col, embeddings
        new_row = pd.DataFrame({
            'category': [category],
            'question': [question],
            'answer': [answer]
        })
        
        # Use pd.concat instead of append
        df_col = pd.concat([df_col, new_row], ignore_index=True)

        # Recompute embeddings for the new question
        new_embedding = model.encode([question])
        embeddings = np.vstack([embeddings, new_embedding])

        # Return a success response
        return Response({'message': 'Question added successfully'}, status=status.HTTP_201_CREATED)

    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
