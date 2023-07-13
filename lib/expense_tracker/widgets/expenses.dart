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
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Udemy Flutter 강의',
      amount: 19000,
      date: DateTime(2023, 7, 2),
      category: Category.study,
    ),
    Expense(
      title: '코드 팩토리 플러터 책',
      amount: 36000,
      date: DateTime(2023, 7, 11),
      category: Category.study,
    ),
    Expense(
      title: '아바타 물의길',
      amount: 14000,
      date: DateTime(2023, 7, 10),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const NewExpense();
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
