import 'package:flutter/material.dart';
import 'package:saras_faqs/utils/colors.dart';

class FAQItem extends StatelessWidget {
  const FAQItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: sarasOrange.withAlpha(50),
      backgroundColor: sarasOrange.withAlpha(50),
      title: title,
      children: children,
    );
  }
}
