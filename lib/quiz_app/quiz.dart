import 'package:first_web/quiz_app/data/questions.dart';
import 'package:first_web/quiz_app/question_screen.dart';
import 'package:first_web/quiz_app/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = StartScreen(switchScreen);
  }

  void switchScreen() {
    setState(() {
      currentScreen = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        selectedAnswers = [];
        currentScreen = StartScreen(switchScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Column(
        children: [
          Expanded(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.amber, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: currentScreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
