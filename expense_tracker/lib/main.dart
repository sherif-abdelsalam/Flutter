import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kDarkColorScheme.primary, // Primary color from color scheme
            foregroundColor: kDarkColorScheme.onPrimary, // Text color
            elevation: 4, // Elevation
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
        ),
      ),
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onInverseSurface,
        ),
        cardTheme: CardTheme(
          color: kColorScheme.secondaryContainer,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kColorScheme.primary, // Primary color from color scheme
            foregroundColor: kColorScheme.onPrimary, // Text color
            elevation: 4, // Elevation
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // default
      home: const Expenses(),
    ),
  );
}
