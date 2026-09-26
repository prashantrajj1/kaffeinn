import 'package:flutter/material.dart';

class KaffeinnLogo extends StatelessWidget {
  final double width;

  const KaffeinnLogo({
    super.key,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images2/logo.png',
      width: width,
      fit: BoxFit.contain,
    );
  }
}