import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class KaffeinnInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;

  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const KaffeinnInput({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      style: const TextStyle(
        fontSize: 16,
        color: KaffeinnColors.black,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Color(0xFF444444),
          fontSize: 16,
        ),

        prefixIcon: Icon(
          icon,
          color: KaffeinnColors.primary,
          size: 25,
        ),

        suffixIcon: suffixIcon,

        filled: true,

        fillColor: KaffeinnColors.inputBackground,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 18,
        ),
      ),
    );
  }
}