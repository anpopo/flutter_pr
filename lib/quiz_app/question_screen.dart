import 'package:first_web/quiz_app/answer_button.dart';
import 'package:first_web/quiz_app/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<StatefulWidget> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentIndex = 0;

  void nextQuestion(String answer) {
    var onSelectAnswer = widget.onSelectAnswer;
    setState(() {
      currentIndex++;
      onSelectAnswer(answer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Q. ${currentQuestion.question}',
              style: GoogleFonts.alkatra(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentQuestion.answers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTab: () {
                  nextQuestion(answer);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
