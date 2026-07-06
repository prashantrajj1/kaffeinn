import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/student_repository.dart';
import '../dashboard/dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Initialize repository and check login status in parallel
    await Future.wait([
      StudentRepository.instance.init(),
      SharedPreferences.getInstance().then((prefs) => prefs.getBool('isLoggedIn') ?? false),
    ]).then((results) {
      final bool isLoggedIn = results[1] as bool;

      Timer(
        const Duration(seconds: 2),
        () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => isLoggedIn ? const DashboardScreen() : const LoginScreen(),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              "assets/images2/logo.png",
              width: 160,
            ),

            const SizedBox(height: 30),

            const Text(
              "Kaffienn",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xff173A70),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Making Food Delicious...",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}