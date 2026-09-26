import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/kaffeinn_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hidePassword = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rollController = TextEditingController();
  final roomController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    rollController.dispose();
    roomController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _createAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Account registration will be connected to backend later.",
        ),
      ),
    );
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
                  40,
                  38,
                  40,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),

                child: Column(
                  children: [
                    KaffeinnInput(
                      hint: "Full Name",
                      icon: Icons.person_outline,
                      controller: nameController,
                    ),

                    const SizedBox(height: 20),

                    KaffeinnInput(
                      hint: "Email",
                      icon: Icons.email_outlined,
                      controller: emailController,
                    ),

                    const SizedBox(height: 20),

                    KaffeinnInput(
                      hint: "Phone",
                      icon: Icons.phone_outlined,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 20),

                    KaffeinnInput(
                      hint: "Roll No.",
                      icon: Icons.badge_outlined,
                      controller: rollController,
                    ),

                    const SizedBox(height: 20),

                    KaffeinnInput(
                      hint: "Room No.",
                      icon: Icons.meeting_room_outlined,
                      controller: roomController,
                    ),

                    const SizedBox(height: 20),

                    KaffeinnInput(
                      hint: "Password",
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

                    const SizedBox(height: 30),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hostel",
                        style: TextStyle(
                          color: AppColors.wine,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: "Select Hostel",
                        prefixIcon: Icon(
                          Icons.apartment_outlined,
                          color: AppColors.wine,
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "Hostel A",
                          child: Text("Hostel A"),
                        ),
                        DropdownMenuItem(
                          value: "Hostel B",
                          child: Text("Hostel B"),
                        ),
                        DropdownMenuItem(
                          value: "Hostel C",
                          child: Text("Hostel C"),
                        ),
                      ],

                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _createAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.wine,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 490,

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
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          const SizedBox(height: 15),

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
              height: 120,
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            "Create Account 🚀",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Join Kaffeinn Food today",
            style: TextStyle(
              color: Color(0xFFFFDDE1),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}