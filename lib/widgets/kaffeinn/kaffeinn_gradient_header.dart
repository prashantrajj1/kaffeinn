import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class KaffeinnGradientHeader extends StatelessWidget {
  final Widget child;
  final double height;

  const KaffeinnGradientHeader({
    super.key,
    required this.child,
    this.height = 330,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,

      decoration: const BoxDecoration(
        gradient: KaffeinnTheme.headerGradient,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),

      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}