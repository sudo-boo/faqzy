import 'package:flutter/material.dart';
import 'package:saras_faqs/utils/colors.dart';

class FAQItem extends StatelessWidget {
  const FAQItem({
    Key? key,
    required this.category,
    required this.question,
    required this.answer,
  }) : super(key: key);

  final String category;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: sarasOrange.withAlpha(20),
      backgroundColor: sarasOrange.withAlpha(20),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: sarasOrange.withAlpha(100),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
            child: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: Text(
            answer,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
