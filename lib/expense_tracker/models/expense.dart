import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food,
  bills,
  transport,
  leisure,
  shopping,
  study,
  other,
}

const categoryIcon = {
  Category.food: Icons.fastfood,
  Category.bills: Icons.receipt,
  Category.transport: Icons.directions_bus,
  Category.leisure: Icons.sports_soccer,
  Category.shopping: Icons.shopping_bag,
  Category.study: Icons.book,
  Category.other: Icons.more_horiz,
};

final _formatter = DateFormat.yMd();


class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => _formatter.format(date);

}
