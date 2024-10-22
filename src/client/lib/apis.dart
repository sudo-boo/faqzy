// apis.dart

import 'config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saras_faqs/utils/answer_results_item.dart';


// Function to make the HTTP POST request
Future<AnswerResult> getAnswer(String query) async {
  try {
    final Map<String, dynamic> body = {"query": query};
    final response = await http.post(
      Uri.parse(userGetAnswer),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final topQuestions = responseData['top_5_questions'];

      if (topQuestions.isNotEmpty) {
        return AnswerResult(
          bestMatch: topQuestions[0],
          seeAlso: topQuestions.sublist(1),
          responseText: 'No answer yet',
        );
      } else {
        return AnswerResult(
          bestMatch: null,
          seeAlso: [],
          responseText: 'No relevant questions found.',
        );
      }
    } else {
      return AnswerResult(
        bestMatch: null,
        seeAlso: [],
        responseText: 'Error: ${response.reasonPhrase}',
      );
    }
  } catch (e) {
    return AnswerResult(
      bestMatch: null,
      seeAlso: [],
      responseText: 'Failed to connect to the server: $e',
    );
  }
}
