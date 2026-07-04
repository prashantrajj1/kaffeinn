import 'package:flutter/material.dart';
import '../../widgets/meal_card.dart';
import '../../widgets/app_drawer.dart';
import '../scanner/qr_scanner_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xffC7DB1E),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 34,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),

                  FloatingActionButton(
                    heroTag: "top",
                    mini: true,
                    backgroundColor: Colors.blue,
                    elevation: 8,
                    onPressed: () {
                      // Top-up Balance (we'll implement later)
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const Text(
                "Topup Balance",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Rs 0",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),

              const SizedBox(height: 20),

              /// Meal Cards
              Expanded(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.82,
                  children: const [
                    MealCard(
                      title: "Breakfast",
                      taken: "0",
                      available: "15",
                      image: "assets/images/breakfast.png",
                    ),
                    MealCard(
                      title: "Lunch",
                      taken: "0",
                      available: "22",
                      image: "assets/images/lunch.png",
                    ),
                    MealCard(
                      title: "Dinner",
                      taken: "0",
                      available: "10",
                      image: "assets/images/dinner.png",
                    ),
                    MealCard(
                      title: "Spl. Dinner",
                      taken: "0",
                      available: "5",
                      image: "assets/images/special_dinner.png",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// QR Button
              Center(
                child: FloatingActionButton(
                  heroTag: "qr",
                  backgroundColor: Colors.blue,
                  elevation: 8,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRScannerScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.qr_code_scanner, size: 30),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
