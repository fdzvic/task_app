import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';

class CustomTheme {
  ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colors.primaryColor),
    useMaterial3: true,
    primaryColor: colors.primaryColor,
    scaffoldBackgroundColor: colors.backgroundColor,
    appBarTheme: AppBarTheme(color: colors.primaryColor),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: colors.textColor,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: colors.textColor,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: colors.textColor,
        fontSize: 12,
      ),
    ),
  );
}
