import 'package:flutter/cupertino.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({
    super.key,
    required this.summaryData,
  });

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: summaryData.map((data) {
        return Row(
          children: [
            Text(((data['questionIndex'] as int) + 1).toString()),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(data['question'] as String),
                  Text('Correct Answer: ${data['correctAnswer']}'),
                  Text('Your Answer: ${data['userAnswer']}'),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
