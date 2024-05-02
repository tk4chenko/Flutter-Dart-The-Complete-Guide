import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text,
      {super.key,
      this.color = Colors.white,
      this.fontSize = 28,
      this.fontFamilly = 'Roboto',
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center});

  final String text;
  final Color color;
  final double fontSize;
  final String fontFamilly;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.getFont(
          fontFamilly,
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      );
}
