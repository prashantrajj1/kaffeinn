import 'package:flutter/material.dart';

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
    return Card(
      elevation: 8,
      shadowColor: Colors.black45,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color(0xff203B70),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                  size: 45,
                );
              },
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Taken $taken",
              style: const TextStyle(color: Colors.grey, fontSize: 12.5),
            ),

            Text(
              "Available $available",
              style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
