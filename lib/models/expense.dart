import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, schoolFees, clothing, leisure, travel, work }

final categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.schoolFees: Icons.school,
  Category.clothing: Icons.shopping_cart,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = uuid.v4();

  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final String id;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.expenses,
    required this.category,
  });
  final List<Expense> expenses;
  final Category category;

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalAmount {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
