import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/gradient_container.dart';
import 'package:quiz_app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

enum Screen {
  start,
  questions,
  results,
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = Screen.start;

  void switchScreen() {
    setState(() {
      switch (activeScreen) {
        case Screen.start:
          activeScreen = Screen.questions;
        case Screen.results:
        selectedAnswers = [];
          activeScreen = Screen.start;
        default:
      }
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = Screen.results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GradientContainer.purple(
          child: _activeScreen(),
        ),
      ),
    );
  }

  Widget _activeScreen() {
    switch (activeScreen) {
      case Screen.start:
        return StartScreen(switchScreen);
      case Screen.questions:
        return QuestionsScreen(onSelectAnswer: chooseAnswer);
      case Screen.results:
        return ResultsScreen(
            chosenAnswers: selectedAnswers, onRestartQuiz: switchScreen);
      default:
        return StartScreen(switchScreen);
    }
  }
}
