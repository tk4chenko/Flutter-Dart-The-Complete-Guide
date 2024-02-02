import 'package:flutter/material.dart';

final class StyledText extends StatelessWidget {

  const StyledText(this.text , {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        );
  }
}