import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get primaryContainerColor =>
      Theme.of(this).colorScheme.onPrimaryContainer;
  Color get buttonColor => Theme.of(this).colorScheme.secondary;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      );
}
