import 'dart:math';

import 'package:first_web/random_dice/styled_text.dart';
import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<StatefulWidget> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 1;

  void _rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const StyledText(
          'Random Dice 🔥',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        OutlinedButton(
          onPressed: _rollDice,
          child: const Text('Roll Dice!'),
        )
      ],
    );
  }
}
