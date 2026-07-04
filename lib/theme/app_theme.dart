import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF173A70),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF173A70),
    ),
  );
}