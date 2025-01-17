import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, {super.key, required this.onClick});

  final String answerText;
  final void Function() onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed:onClick,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 4, 34, 58),
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
