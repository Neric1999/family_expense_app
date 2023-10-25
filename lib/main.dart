import 'package:family_expenses/widgets/expenses.dart';
import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 113, 58, 190),
);

final kDarkMode = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 58, 114, 255),
  brightness: Brightness.dark,
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkMode,
        cardTheme: const CardTheme().copyWith(
          color: kDarkMode.primaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
          actionTextColor: kDarkMode.primaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          color: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
