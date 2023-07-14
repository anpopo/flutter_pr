import 'package:first_web/expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:first_web/expense_tracker/models/expense.dart';
import 'package:first_web/expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _addNewExpense(
      String title, double amount, DateTime date, Category category) {
    setState(() {
      _registeredExpenses.add(
        Expense(
          title: title,
          amount: amount,
          date: date,
          category: category,
        ),
      );
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewExpense(
          addExpense: _addNewExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지출 내역'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          const Placeholder(),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
