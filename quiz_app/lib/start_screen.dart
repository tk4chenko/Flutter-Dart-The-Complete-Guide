import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  
final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        direction: Axis.vertical,
        spacing: 40,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset('assets/images/quiz-logo.png', height: 240),
          ),
           Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape:
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            onPressed: startQuiz,
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      );
  }

}
