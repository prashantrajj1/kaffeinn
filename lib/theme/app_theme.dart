import 'package:flutter/material.dart';

class AppColors {
  static const Color wine = Color(0xFF971827);
  static const Color wineDark = Color(0xFF841321);

  static const Color coral = Color(0xFFE45C6A);
  static const Color coralLight = Color(0xFFF08A96);

  static const Color background = Color(0xFFF8F7FA);
  static const Color softPink = Color(0xFFFFF4F4);
  static const Color input = Color(0xFFF7F7F7);

  static const Color text = Color(0xFF171717);
  static const Color muted = Color(0xFF999999);

  static const Color white = Colors.white;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.wine,
      primary: AppColors.wine,
    ),

    fontFamily: 'Roboto',

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.text,
      ),
      bodyMedium: TextStyle(
        color: AppColors.text,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.input,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(
          color: AppColors.wine,
          width: 1.5,
        ),
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 19,
      ),
    ),
  );
}