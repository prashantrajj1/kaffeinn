import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/kaffeinn_bottom_nav.dart';
import '../bookings/book_meal_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            _header(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  25,
                  20,
                  20,
                ),
                children: [
                  _menuTile(
                    icon: Icons.person,
                    title: "Profile",
                    subtitle: "User Details",
                    color: AppColors.wine,
                    onTap: () {},
                  ),

                  _menuTile(
                    icon: Icons.restaurant,
                    title: "Book Meal",
                    subtitle: "Book meals quickly",
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BookMealScreen(),
                        ),
                      );
                    },
                  ),

                  _menuTile(
                    icon: Icons.history,
                    title: "History",
                    subtitle: "View all transactions",
                    color: Colors.orange,
                    onTap: () {},
                  ),

                  _menuTile(
                    icon: Icons.restaurant_menu,
                    title: "Weekly Menu",
                    subtitle: "Food menu",
                    color: Colors.blue,
                    onTap: () {},
                  ),

                  _menuTile(
                    icon: Icons.support_agent,
                    title: "Feedback",
                    subtitle: "Feedback",
                    color: Colors.pink,
                    onTap: () {},
                  ),

                  _menuTile(
                    icon: Icons.delete_forever,
                    title: "Delete Account",
                    subtitle: "Delete your account",
                    color: AppColors.wine,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: KaffeinnBottomNav(
        selectedIndex: 1,
        onItemSelected: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        34,
        30,
        25,
        30,
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

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Access",
            style: TextStyle(
              color: Color(0xFFFFDDE1),
              fontSize: 17,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Quick Links",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,

              decoration: BoxDecoration(
                color: color,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Icon(
                Icons.chevron_right,
                color: color,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}