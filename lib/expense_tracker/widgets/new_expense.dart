import 'dart:io';

import 'package:first_web/expense_tracker/models/expense.dart';
import 'package:first_web/expense_tracker/utils/date_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(
      String title, double amount, DateTime date, Category category) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate = DateTime.now();
  Category _category = Category.food;

  void _showDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Plz fill all the fields Correctly ✋'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Plz fill all the fields Correctly ✋'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || amountIsInvalid || _pickedDate == null) {
      _showDialog();
      return;
    }

    widget.addExpense(enteredTitle, enteredAmount, _pickedDate!, _category);
    Navigator.pop(context);
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _pickedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        var isMaxWidthOver600 = constraints.maxWidth > 600;

        isMaxWidthOver600 ? keyboardSpace = 0 : keyboardSpace = keyboardSpace;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0 + keyboardSpace),
              child: isMaxWidthOver600
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                maxLength: 50,
                                keyboardType: TextInputType.text,
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  hintText: 'Enter title ',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _amountController,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  hintText: 'Enter amount ',
                                  prefixText: '₩ ',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            DropdownButton(
                              value: _category,
                              items: Category.values
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.name.toUpperCase(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }

                                setState(() {
                                  _category = value;
                                });
                              },
                              style:
                                  Theme.of(context).dropdownMenuTheme.textStyle,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _pickedDate == null
                                        ? 'Select Date'
                                        : DateFormatter.format(_pickedDate!),
                                  ),
                                  IconButton(
                                    onPressed: _showDatePicker,
                                    icon: const Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: _submitExpenseData,
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        TextField(
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter title ',
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _amountController,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  hintText: 'Enter amount ',
                                  prefixText: '₩ ',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _pickedDate == null
                                        ? 'Select Date'
                                        : DateFormatter.format(_pickedDate!),
                                  ),
                                  IconButton(
                                    onPressed: _showDatePicker,
                                    icon: const Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            DropdownButton(
                              value: _category,
                              items: Category.values
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.name.toUpperCase(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }

                                setState(() {
                                  _category = value;
                                });
                              },
                              style:
                                  Theme.of(context).dropdownMenuTheme.textStyle,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _submitExpenseData,
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
