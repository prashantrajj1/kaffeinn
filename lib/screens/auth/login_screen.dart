import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_theme.dart';
import '../../widgets/kaffeinn_input.dart';
import 'signup_screen.dart';
import '../dashboard/dashboard_screen.dart';

const String validEmail = "usr69";
const String validPassword = "69";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email == validEmail && password == validPassword) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(
        'isLoggedIn',
        true,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password"),
          backgroundColor: AppColors.wine,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F8),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),

              const SizedBox(height: 55),

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 34,
                ),

                padding: const EdgeInsets.fromLTRB(
                  38,
                  45,
                  38,
                  40,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    KaffeinnInput(
                      hint: "Enter your email",
                      icon: Icons.email_outlined,
                      controller: emailController,
                      keyboardType:
                          TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 24),

                    KaffeinnInput(
                      hint: "Enter your password",
                      icon: Icons.lock_outline,
                      controller: passwordController,
                      obscureText: hidePassword,

                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.wine,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.wine,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.wine,
                          foregroundColor: Colors.white,

                          elevation: 5,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(28),
                          ),
                        ),

                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.wine,
                          fontSize: 16,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Don't have an account? ",
                          ),

                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColors.wine,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 520,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF971827),
            Color(0xFFE85C6A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),
      ),

      child: Column(
        children: [
          const SizedBox(height: 85),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 75,
            ),

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
            ),

            child: Image.asset(
              "assets/images/kaffeinn_logo.png",
              height: 125,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 48),

          const Text(
            "Welcome Back 👋",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Login to continue your meal booking",
            style: TextStyle(
              color: Color(0xFFFFDDE1),
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}