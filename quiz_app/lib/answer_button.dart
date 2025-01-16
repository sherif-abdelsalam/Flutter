import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, this.onClick, {super.key});

  final String answerText;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onClick,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 4, 34, 58),
      ),
      child: Text(answerText),
    );
  }
}
