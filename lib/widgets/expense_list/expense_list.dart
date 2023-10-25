// ignore_for_file: must_be_immutable

import 'package:family_expenses/models/expense.dart';
import 'package:family_expenses/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemovedExpense,
  });

  final List<Expense> expenses;
  void Function(Expense) onRemovedExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            margin: Theme.of(context).cardTheme.margin,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          key: ValueKey(
            ExpenseItem(expense: expenses[index]),
          ),
          child: ExpenseItem(expense: expenses[index]),
          onDismissed: (direction) {
            onRemovedExpense(expenses[index]);
          },
        );
      },
    );
  }
}
