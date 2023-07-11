import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  final bool isCorrectAnswer;
  final int questionIndex;

  const QuestionIdentifier({
    super.key,
    required this.isCorrectAnswer,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isCorrectAnswer
            ? Colors.green
            : Colors.red,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          "${questionIndex + 1}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
