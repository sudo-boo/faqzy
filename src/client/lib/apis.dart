// apis.dart

import 'dart:core';
import 'config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saras_faqs/utils/answer_results_item.dart';

// Function to make the HTTP POST request
Future<AnswerResult> getAnswer(String query) async {
  final Stopwatch stopwatch = Stopwatch()..start();

  try {
    final Map<String, dynamic> body = {"query": query};
    final response = await http.post(
      Uri.parse(userGetAnswer),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    stopwatch.stop();

    final elapsedTime = stopwatch.elapsed.inMicroseconds / 1e6;
    final formattedTime = elapsedTime.toStringAsFixed(4);

    // Check if the request was successful
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final topQuestions = responseData['top_5_questions'];

      if (topQuestions.isNotEmpty) {
        return AnswerResult(
          bestMatch: topQuestions[0],
          seeAlso: topQuestions.sublist(1),
          responseText: 'No answer yet',
          timeTaken: formattedTime,
        );
      } else {
        return AnswerResult(
          bestMatch: null,
          seeAlso: [],
          responseText: 'No relevant questions found.',
          timeTaken: formattedTime,
        );
      }
    } else {
      return AnswerResult(
        bestMatch: null,
        seeAlso: [],
        responseText: 'Error: ${response.reasonPhrase}',
        timeTaken: formattedTime,
      );
    }
  } catch (e) {
    return AnswerResult(
      bestMatch: null,
      seeAlso: [],
      responseText: 'Failed to connect to the server: $e',
      timeTaken: '0.0000',
    );
  }
}



Future<void> submitQuery(
    BuildContext context,
    String question,
    String answer,
    String category,
    ) async {
  // Construct the request body
  final Map<String, dynamic> body = {
    'question': question,
    'answer': answer,
    'category': category,
  };

  // Perform the POST request
  final response = await http.post(
    Uri.parse(userAddQuery), // Replace with your API endpoint
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(body),
  );

  // Handle the response
  if (response.statusCode == 201) {
    // Successfully submitted
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Query submitted successfully!')),
    );
  } else {
    // Handle error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit query: ${response.reasonPhrase}')),
    );
  }
}