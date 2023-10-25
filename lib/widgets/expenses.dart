import 'package:family_expenses/models/expense.dart';
import 'package:family_expenses/widgets/chart/chart.dart';
import 'package:family_expenses/widgets/expense_list/expense_list.dart';
import 'package:family_expenses/widgets/expense_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final _registeredExpenses = [
    Expense(
      title: 'Fees',
      amount: 276.38,
      category: Category.schoolFees,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Rice',
      amount: 300,
      category: Category.food,
      date: DateTime.now(),
    ),
  ];

  void _onShowModalOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewExpense(
          onAddedExpense: _onAddingExpense,
        );
      },
    );
  }

  void _onAddingExpense(expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _onDeletedExpense(expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(
          seconds: 3,
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget activeScreen = const Center(
      child: Text(
        'No available expense. Start adding some!',
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      activeScreen = ExpenseList(
        expenses: _registeredExpenses,
        onRemovedExpense: _onDeletedExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Expenses app'),
        actions: [
          IconButton(
            onPressed: _onShowModalOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: activeScreen,
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: activeScreen,
                )
              ],
            ),
    );
  }
}
