// faqs_home_page.dart

import 'package:saras_faqs/apis.dart';
import 'package:flutter/material.dart';
import 'package:saras_faqs/pages/add_new_query_page.dart';
import 'package:saras_faqs/utils/colors.dart';
import 'package:saras_faqs/utils/faq_item.dart';
import 'package:saras_faqs/utils/answer_results_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _responseText = 'Your search results here...';
  Map<String, dynamic>? bestMatch;
  List<dynamic>? seeAlso;
  String? searchTime;
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/icon.png", width: 35),
            const SizedBox(width: 10),
            const Text('FAQs'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewQueryPage()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Ask a Question:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _queryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your query',
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Submit button to trigger the query
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String query = _queryController.text.trim();
                    if (query.isNotEmpty) {
                      AnswerResult result = await getAnswer(query);
                      setState(() {
                        bestMatch = result.bestMatch;
                        seeAlso = result.seeAlso;
                        _responseText = result.responseText;
                        searchTime = result.timeTaken;
                      });
                    } else {
                      setState(() {
                        _responseText = 'Please enter a query';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sarasOrange,
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Display the best match using FAQItem widget
              if (bestMatch != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Found results in $searchTime seconds...",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Best Match",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    FAQItem(
                      category: bestMatch!['category'],
                      question: bestMatch!['question'],
                      answer: bestMatch!['answer'],
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_responseText, style: const TextStyle(color: Colors.red)),
                ),

              const SizedBox(height: 20),

              if (seeAlso != null && seeAlso!.isNotEmpty) ...[
                const Text('See Also:', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                ...seeAlso!.asMap().entries.map((entry) {
                  int index = entry.key;
                  var question = entry.value;
                  return Column(
                    children: [
                      FAQItem(
                        category: question!['category'],
                        question: question!['question'],
                        answer: question!['answer'],
                      ),
                      if (index != seeAlso!.length - 1) const Divider(),
                    ],
                  );
                }).toList(),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
