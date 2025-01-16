import 'package:flutter/material.dart';
// import "package:first_app/styled_text.dart";
import 'package:first_app/state_roller.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;



class GradientContainer extends StatelessWidget {
  final List<Color> outColors;
  const GradientContainer(this.outColors, {super.key});
  const GradientContainer.purple({super.key})
      : outColors = const [
          Colors.deepPurple,
          Colors.indigo,
        ];

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: outColors,
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
