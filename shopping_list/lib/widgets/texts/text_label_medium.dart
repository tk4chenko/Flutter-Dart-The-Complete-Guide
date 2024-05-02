import 'package:flutter/material.dart';

class TextLabelMedium extends StatelessWidget {
  const TextLabelMedium(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
