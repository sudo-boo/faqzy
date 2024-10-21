from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.decomposition import PCA
import pandas as pd
import numpy as np

df_col = pd.read_csv('datascienceQnA.csv')
model = SentenceTransformer("all-MiniLM-L6-v2")

sentences = df_col['Question'].tolist()
embeddings = model.encode(sentences)
query = ["How do you predict the probability of my death?"]
query_embedding = model.encode(query)

similarities = cosine_similarity(embeddings, query_embedding)
max_similarity_index = np.argmax(similarities)
max_similarity_sentence = df_col['Question'][max_similarity_index]

print(f"Sentence with max similarity: {max_similarity_sentence}")
print("Simlarity gt 0.5:\n")
print("------------------")
for simi in similarities:
    if simi > 0.5:
        print(f"Similarity score: {simi}")
        print(f"Question: {df_col['Question'][similarities.tolist().index(simi)]}")

print("------------------")
print(f" Max Similarity score: {similarities[max_similarity_index][0]}")

