import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    this.colors,
    this.child,
    super.key});

   GradientContainer.purple({super.key, this.child})
      : colors = [Colors.deepPurple, Colors.purple];

  final Widget? child;
  final List<Color>? colors;

  final startAlignment = Alignment.topLeft;
  final endAlignment = Alignment.bottomRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
