import 'package:first_web/quiz_app/question_summary.dart';
import 'package:flutter/material.dart';
import 'package:first_web/quiz_app/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.selectedAnswers,
  });

  final List<String> selectedAnswers;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add(
        {
          'questionIndex': i,
          'question': questions[i].question,
          'correctAnswer': questions[i].answers[0],
          'userAnswer': selectedAnswers[i],
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> summary = getSummaryData();
    final int correctAnswers = summary
        .where((element) => element['correctAnswer'] == element['userAnswer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You got $correctAnswers correct answers out of ${summary.length} questions!',
            ),
            const SizedBox(
              height: 20,
            ),
            QuestionSummary(
              summaryData: summary,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('retry quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
