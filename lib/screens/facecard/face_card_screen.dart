import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

class FaceCardScreen extends StatefulWidget {
  final String studentName;
  final String rollNo;
  final Color backgroundColor;
  final String imagePath;

  const FaceCardScreen({
    super.key,
    required this.studentName,
    required this.rollNo,
    required this.backgroundColor,
    required this.imagePath,
  });

  @override
  State<FaceCardScreen> createState() => _FaceCardScreenState();
}

class _FaceCardScreenState extends State<FaceCardScreen> {
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playSuccessSound();
  }

  Future<void> _playSuccessSound() async {
    await player.play(
      AssetSource('sounds/beep.mp3'),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// Determines the meal name based on the current time of day.
  /// 5:00 AM - 10:59 AM -> Breakfast
  /// 11:00 AM - 3:59 PM -> Lunch
  /// otherwise           -> Dinner
  String _getMealName(DateTime now) {
    final hour = now.hour;
    if (hour >= 5 && hour < 11) {
      return "Breakfast";
    } else if (hour >= 11 && hour < 16) {
      return "Lunch";
    } else {
      return "Dinner";
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final mealName = _getMealName(now);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
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
                    child: Image.file(
                      File(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
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
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Roll Number
                Text(
                  "Roll no. ${widget.rollNo}",
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
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                /// Student Name
                Text(
                  widget.studentName,
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