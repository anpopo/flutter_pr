import 'package:flutter/material.dart';

import 'gradient_container.dart';

class RandomDiceWidget extends StatelessWidget {
  const RandomDiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [Colors.deepPurple, Colors.greenAccent],
        ),
      ),
    );
  }
}
