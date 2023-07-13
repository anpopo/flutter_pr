import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  var _titleInput = '';

  void _saveTitleInput(String value) {
    _titleInput = value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              keyboardType: TextInputType.text,
              onChanged: _saveTitleInput,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter title ',
              ),
            ),
            const Row(
              children: [],
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleInput);
                },
                child: const Text('print expense'),
              ),
            ])
          ],
        ));
  }
}
