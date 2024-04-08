import 'package:flutter/material.dart';

class HyperlinkedText extends StatelessWidget {
  const HyperlinkedText(
      {required this.onTap, required this.text, this.style, super.key});
  final String text;
  final Function() onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: style?.copyWith(decoration: TextDecoration.underline),
      ),
    );
  }
}
