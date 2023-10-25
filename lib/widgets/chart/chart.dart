import 'package:family_expenses/models/expense.dart';
import 'package:family_expenses/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.clothing),
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.schoolFees),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;

    for (final bucket in buckets) {
      if (bucket.totalAmount >= maxTotalExpenses) {
        maxTotalExpenses = bucket.totalAmount;
      }
    }
    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.35),
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalAmount == 0
                        ? 0
                        : bucket.totalAmount / maxTotalExpenses,
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final bucket in buckets)
                  Expanded(
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: isDarkMode
                          ? ThemeData.dark().colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
