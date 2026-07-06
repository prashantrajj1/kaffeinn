import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  runApp(const KaffeinnApp());
}

class KaffeinnApp extends StatelessWidget {
  const KaffeinnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaffienn',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
