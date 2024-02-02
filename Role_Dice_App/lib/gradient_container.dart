import 'package:roll_dice_app/dice_roller.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({required this.colors, super.key});

  GradientContainer.purple({super.key})
      : colors = [Colors.purple, Colors.deepPurple];

  final List<Color> colors;

  final startAlignment = Alignment.topLeft;
  final endAlignment = Alignment.bottomRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
