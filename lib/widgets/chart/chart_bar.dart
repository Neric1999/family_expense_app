import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });
  final double fill;
  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: fill,
        widthFactor: 0.8,
        child: DecoratedBox(
          decoration: ShapeDecoration.fromBoxDecoration(
            BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  10,
                ),
              ),
              color: isDarkMode
                  ? ThemeData.dark().colorScheme.secondary.withOpacity(0.65)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
