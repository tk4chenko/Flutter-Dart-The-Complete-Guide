import 'package:flutter/material.dart';
import 'dart:math';

final class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

final class _DiceRollerState extends State<DiceRoller> {
  final randomiser = Random();
  var currentDiceRoll = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/dice-images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: rollDice,
          child: const Text('Roll Dice'),
        )
      ],
    );
  }

  void rollDice() {
    setState(() {
      currentDiceRoll = randomiser.nextInt(6) + 1;
    });
  }
}
