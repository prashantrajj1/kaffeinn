import 'package:flutter/material.dart';

class MealApprovedScreen extends StatelessWidget {
  final String studentName;
  final String rollNo;
  final String mealType;

  const MealApprovedScreen({
    super.key,
    required this.studentName,
    required this.rollNo,
    required this.mealType,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final hour =
        now.hour % 12 == 0 ? 12 : now.hour % 12;

    final minute =
        now.minute.toString().padLeft(2, '0');

    final period =
        now.hour >= 12 ? 'PM' : 'AM';

    return Scaffold(
      backgroundColor: const Color(0xFFFF0A8A),

      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),

            // Back button
            Positioned(
              top: 10,
              left: 12,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 80),

                // =================================================
                // APPROVED TEXT
                // =================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Text(
                      '✓',
                      style: TextStyle(
                        color: Color(0xFF50E4AE),
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      '$mealType Approved.',
                      style: const TextStyle(
                        color: Color(0xFF50E4AE),
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 45),

                // =================================================
                // APPROVAL CIRCLE
                // =================================================

                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF303030),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 105,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                // =================================================
                // STUDENT INFORMATION
                // =================================================

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 28,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Column(
                    children: [
                      Text(
                        studentName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFFE04F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Roll no. $rollNo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 22),

                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.12),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Color(0xFF4FA7FF),
                            size: 19,
                          ),

                          const SizedBox(width: 7),

                          Text(
                            '$date • $hour:$minute $period',
                            style: const TextStyle(
                              color: Color(0xFF4FA7FF),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: Text(
                    'Meal booking verified successfully',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}