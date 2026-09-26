import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
        fontSize: 17,
        color: AppColors.text,
      ),

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF777777),
          fontSize: 17,
        ),

        prefixIcon: Icon(
          icon,
          color: AppColors.wine,
          size: 27,
        ),

        suffixIcon: suffixIcon,
      ),
    );
  }
}