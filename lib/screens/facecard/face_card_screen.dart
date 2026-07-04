import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FaceCardScreen extends StatelessWidget {
  final String mealName;
  final String studentName;
  final String rollNo;
  final bool isVeg;
  final Color backgroundColor;
  final String imagePath;

  const FaceCardScreen({
    super.key,
    required this.mealName,
    required this.studentName,
    required this.rollNo,
    required this.isVeg,
    required this.backgroundColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Student Photo
                Container(
                  width: 170,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRect(
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(height: 25),

                /// Meal Approved
                Text(
                  "$mealName Approved.",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff66FFFF),
                    shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                  ),
                ),

                const SizedBox(height: 8),

                /// Veg / Non Veg
                Text(
                  isVeg ? "Veg" : "Non Veg",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isVeg ? Colors.yellow : Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                /// Roll Number
                Text(
                  "Roll no. $rollNo",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                /// Date & Time
                Text(
                  DateFormat("yyyy-MM-dd  h:mm a").format(now),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                    shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                  ),
                ),

                const SizedBox(height: 35),

                /// Student Name
                Text(
                  studentName,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                /// Home Button
                SizedBox(
                  width: 220,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
