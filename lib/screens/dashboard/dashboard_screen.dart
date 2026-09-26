import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/meal_card.dart';
import '../../widgets/kaffeinn_bottom_nav.dart';
import 'menu_screen.dart';
import '../bookings/book_meal_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  void _changeTab(int index) {
    if (index == 0) {
      // Already on Home
      return;
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MenuScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // TOP HEADER
            // =========================================================
            _topHeader(),

            // =========================================================
            // MAIN CONTENT
            // =========================================================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  30,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // BALANCE CARD
                    // =================================================
                    _balanceCard(),

                    const SizedBox(height: 28),

                    // =================================================
                    // MEAL OVERVIEW HEADING
                    // =================================================
                    _mealHeading(),

                    const SizedBox(height: 18),

                    // =================================================
                    // MEAL CARDS
                    // =================================================
                    GridView.builder(
                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        crossAxisSpacing: 15,

                        mainAxisSpacing: 15,

                        // FIX FOR OVERFLOW
                        mainAxisExtent: 250,
                      ),

                      itemCount: 4,

                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const MealCard(
                              title: "Breakfast",
                              taken: "1",
                              available: "9",
                              image:
                                  "assets/images/breakfast.png",
                            );

                          case 1:
                            return const MealCard(
                              title: "Lunch",
                              taken: "1",
                              available: "9",
                              image:
                                  "assets/images/lunch.png",
                            );

                          case 2:
                            return const MealCard(
                              title: "Dinner",
                              taken: "2",
                              available: "8",
                              image:
                                  "assets/images/dinner.png",
                            );

                          case 3:
                            return const MealCard(
                              title: "Special Dinner",
                              taken: "0",
                              available: "10",
                              image:
                                  "assets/images/spldinner.png",
                            );

                          default:
                            return const SizedBox();
                        }
                      },
                    ),

                    // Extra space so the last card doesn't
                    // touch the bottom navigation.
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =============================================================
      // BOTTOM NAVIGATION
      // =============================================================
      bottomNavigationBar: KaffeinnBottomNav(
        selectedIndex: selectedIndex,
        onItemSelected: _changeTab,
      ),
    );
  }

  // =================================================================
  // TOP HEADER
  // =================================================================

  Widget _topHeader() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        34,
        30,
        25,
        35,
      ),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.wine,
            AppColors.coral,
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),
      ),

      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            "Welcome Back 👋",
            style: TextStyle(
              color: Color(0xFFFFDDE1),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "Sarbeswar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // BALANCE CARD
  // =================================================================

  Widget _balanceCard() {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(
        top: 0,
      ),

      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(35),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [
          // =========================================================
          // BALANCE
          // =========================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // Topup Balance label
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFFFEDEF),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      Icon(
                        Icons
                            .account_balance_wallet_outlined,
                        size: 17,
                        color:
                            AppColors.wine,
                      ),

                      SizedBox(width: 7),

                      Text(
                        "Topup Balance",
                        style: TextStyle(
                          color:
                              AppColors.wine,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "₹ 300.00",
                  style: TextStyle(
                    color: AppColors.wine,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // =========================================================
          // BOOK NOW BUTTON
          // =========================================================

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const BookMealScreen(),
                ),
              );
            },

            child: Container(
              width: 125,
              height: 90,

              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    AppColors.wine,
                    AppColors.coral,
                  ],

                  begin:
                      Alignment.centerLeft,

                  end:
                      Alignment.centerRight,
                ),

                borderRadius:
                    BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color:
                        AppColors.wine
                            .withOpacity(0.18),

                    blurRadius: 12,

                    offset:
                        const Offset(0, 5),
                  ),
                ],
              ),

              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  CircleAvatar(
                    radius: 20,

                    backgroundColor:
                        Color(0x55FFFFFF),

                    child: Icon(
                      Icons.add,
                      color:
                          Colors.white,
                      size: 27,
                    ),
                  ),

                  SizedBox(width: 8),

                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "BOOK",
                        style:
                            TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 12,
                          letterSpacing: 2,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      Text(
                        "NOW",
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontSize: 23,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // MEAL OVERVIEW HEADING
  // =================================================================

  Widget _mealHeading() {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,

      children: [
        const Expanded(
          child: Text(
            "Meal Overview",

            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ),

        const SizedBox(width: 8),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),

          decoration: BoxDecoration(
            color: AppColors.wine,

            borderRadius:
                BorderRadius.circular(22),
          ),

          child: const Row(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              Icon(
                Icons.calendar_month,
                size: 17,
                color: Colors.white,
              ),

              SizedBox(width: 6),

              Text(
                "Today's Bookings",

                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}