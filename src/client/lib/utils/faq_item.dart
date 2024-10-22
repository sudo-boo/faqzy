import 'package:flutter/material.dart';

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
      title: title,
      children: children,
    );
  }
}
