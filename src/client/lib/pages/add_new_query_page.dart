// add_new_query_page.dart

import 'package:saras_faqs/apis.dart';
import 'package:saras_faqs/utils/colors.dart';
import 'package:flutter/material.dart';

class AddNewQueryPage extends StatefulWidget {
  @override
  _AddNewQueryPageState createState() => _AddNewQueryPageState();
}

class _AddNewQueryPageState extends State<AddNewQueryPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New FAQ/Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                submitQuery(
                  context,
                  _questionController.text,
                  _answerController.text,
                  _categoryController.text,
                );
                _questionController.clear();
                _answerController.clear();
                _categoryController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: sarasOrange,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Submit FAQ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
