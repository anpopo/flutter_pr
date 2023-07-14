import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index].id),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: Theme.of(context).cardTheme.margin,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
