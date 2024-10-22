// answer_results_item.dart

class AnswerResult {
  final Map<String, dynamic>? bestMatch;
  final List<dynamic>? seeAlso;
  final String responseText;

  AnswerResult({this.bestMatch, this.seeAlso, required this.responseText});
}