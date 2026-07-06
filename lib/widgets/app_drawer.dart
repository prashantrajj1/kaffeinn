import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_repository.dart';
import '../screens/auth/login_screen.dart';
import '../screens/bookings/booking_history_screen.dart';

class AppDrawer extends StatelessWidget {
  final String name;
  final String rollNo;
  final String? imagePath;

  const AppDrawer({
    super.key,
    required this.name,
    required this.rollNo,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 45,
              backgroundImage: imagePath != null
                  ? FileImage(File(imagePath!))
                  : const AssetImage("assets/images2/login.png") as ImageProvider,
            ),

            const SizedBox(height: 15),

            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(rollNo, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text("Book Meals"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Weekly Food Menu"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Booking History"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
                );
              },
            ),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);

                // Optional: Clear student data on logout
                await StudentRepository.instance.clear();

                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
