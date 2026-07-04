import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage("assets/images/login.png"),
            ),

            const SizedBox(height: 15),

            const Text(
              "Prashant Kumar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Text("ucsc24042", style: TextStyle(color: Colors.grey)),

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
              onTap: () {},
            ),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
