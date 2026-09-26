import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class BookMealScreen extends StatefulWidget {
  const BookMealScreen({super.key});

  @override
  State<BookMealScreen> createState() =>
      _BookMealScreenState();
}

class _BookMealScreenState extends State<BookMealScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedMeal;

  Future<void> _chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 60),
      ),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final date =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            _header(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _dateCard(date),

                    const SizedBox(height: 25),

                    _mealTypeCard(),

                    const SizedBox(height: 25),

                    _variationCard(),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed:
                            selectedMeal == null
                                ? null
                                : () {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "$selectedMeal selected",
                                        ),
                                      ),
                                    );
                                  },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.wine,
                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Continue Booking",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        15,
        25,
        35,
      ),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.wine,
            AppColors.coral,
          ],
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "Book Your Meal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateCard(String date) {
    return Container(
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            "Booking Date",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F5),
              borderRadius:
                  BorderRadius.circular(25),
            ),

            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,

                  decoration: BoxDecoration(
                    color: AppColors.wine,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          color: AppColors.wine,
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Tap choose to change date",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _chooseDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.wine,
                    foregroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text("Choose"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealTypeCard() {
    return Container(
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Meal Type",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Please select a meal type",
            style: TextStyle(
              color: AppColors.coral,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 25),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.15,

            children: [
              _mealButton(
                "Breakfast",
                Icons.local_cafe_outlined,
              ),

              _mealButton(
                "Lunch",
                Icons.lunch_dining,
              ),

              _mealButton(
                "Dinner",
                Icons.dinner_dining,
              ),

              _mealButton(
                "Special Dinner",
                Icons.celebration_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mealButton(
    String title,
    IconData icon,
  ) {
    final selected = selectedMeal == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMeal = title;
        });
      },

      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFEDEF)
              : const Color(0xFFF7F7F7),

          borderRadius: BorderRadius.circular(24),

          border: selected
              ? Border.all(
                  color: AppColors.wine,
                  width: 2,
                )
              : null,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.wine,
              size: 32,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _variationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),

      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            "Select Variation",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 7),

          Text(
            "Please select a variation",
            style: TextStyle(
              color: AppColors.coral,
              fontSize: 15,
            ),
          ),

          SizedBox(height: 30),

          Text(
            "Variation options will appear here.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}