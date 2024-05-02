import 'package:flutter/material.dart';

const Alignment startAlignment = Alignment.topLeft;
const Alignment endAlignment = Alignment.bottomRight;
const Alignment centerAlignment = Alignment.center;
const Widget defaultChild = SizedBox();
const List<Color> defaultColors = [Colors.white];

enum GradientType { linear, circle }

class GradientContainer extends StatelessWidget {
  const GradientContainer.linear({super.key, this.gradientColors = defaultColors, this.child = defaultChild})
      : gradientType = GradientType.linear;
  const GradientContainer.circle({super.key, this.gradientColors = defaultColors, this.child = defaultChild})
      : gradientType = GradientType.circle;

  final GradientType gradientType;
  final List<Color> gradientColors;
  final Widget child;

  final String activeDiceImage = 'assets/images/dice-1.png';

  @override
  Widget build(BuildContext context) => Container(
      decoration: gradientType == GradientType.linear ? getGradientLinearDecoration() : getGradientCircleDecoration(),
      child: child);

  List<double> getGradientStops({start = 0, end = 1}) {
    List<double> stops = [];

    for (int i = 0; i < gradientColors.length; i++) {
      double stop = start + (end - start) / (gradientColors.length - 1) * i;
      // debugPrint('stop: $stop');
      stops.add(stop);
    }

    return stops;
  }

  BoxDecoration getGradientLinearDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: startAlignment,
          end: endAlignment,
          tileMode: TileMode.clamp,
          stops: getGradientStops(),
        ),
      );

  BoxDecoration getGradientCircleDecoration() => BoxDecoration(
        gradient: RadialGradient(
          colors: gradientColors,
          center: centerAlignment,
          radius: 1.4,
          tileMode: TileMode.clamp,
          stops: getGradientStops(start: 0.3),
        ),
      );
}
