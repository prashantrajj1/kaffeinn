import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MealCard extends StatelessWidget {
  final String title;
  final String taken;
  final String available;
  final String image;

  const MealCard({
    super.key,
    required this.title,
    required this.taken,
    required this.available,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================================================
          // MEAL IMAGE
          // =========================================================

          Container(
            width: 66,
            height: 66,

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.wine,
                  AppColors.coral,
                ],

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              borderRadius: BorderRadius.circular(20),
            ),

            padding: const EdgeInsets.all(8),

            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 13),

          // =========================================================
          // MEAL NAME
          // =========================================================

          Text(
            title,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: AppColors.text,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 8),

          // =========================================================
          // TAKEN
          // =========================================================

          Text(
            'Taken $taken',

            style: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          // =========================================================
          // FLEXIBLE SPACE
          // =========================================================

          const Spacer(),

          // =========================================================
          // AVAILABLE
          // =========================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF2F3),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              'Available $available',

              style: const TextStyle(
                color: AppColors.wine,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}