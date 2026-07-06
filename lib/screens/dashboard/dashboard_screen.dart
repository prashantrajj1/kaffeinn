import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/student_repository.dart';
import '../../widgets/meal_card.dart';
import '../../widgets/app_drawer.dart';
import '../scanner/qr_scanner_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Color _selectedColor = const Color(0xff173A70);

  @override
  void initState() {
    super.initState();
    _loadSavedColor();
  }

  Future<void> _loadSavedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? colorValue = prefs.getInt('faceCardColor');
    if (colorValue != null) {
      setState(() {
        _selectedColor = Color(colorValue);
      });
    }
  }

  Future<void> _saveColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('faceCardColor', color.value);
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color for Face Card'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() => _selectedColor = color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                _saveColor(_selectedColor);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Color saved successfully!")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = StudentRepository.instance.entries.isNotEmpty
        ? StudentRepository.instance.entries.first
        : null;

    return Scaffold(
      drawer: AppDrawer(
        name: student?.name ?? "Prashant Kumar",
        rollNo: student?.rollNo ?? "ucsc24042",
        imagePath: student?.imagePath,
      ),
      backgroundColor: const Color(0xffC7DB1E),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Menu Button
                  Row(
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
                    ],
                  ),

                  const SizedBox(height: 70),

                  /// Balance
                  const Text(
                    "Topup Balance",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Rs 0",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Meal Cards
                  Expanded(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                      children: const [
                        MealCard(
                          title: "Breakfast",
                          taken: "0",
                          available: "15",
                          image: "assets/images/breakfast.png",
                        ),
                        MealCard(
                          title: "Lunch",
                          taken: "5",
                          available: "17",
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
                          image: "assets/images/spldinner.png",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// QR Scanner Button
                  Center(
                    child: FloatingActionButton(
                      heroTag: "qr",
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const QRScannerScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.qr_code_scanner,
                        size: 30,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),

              /// Top-up Button
              Positioned(
                top: 130,
                right: 10,
                child: FloatingActionButton(
                  heroTag: "top",
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shape: const CircleBorder(),
                  onPressed: _showColorPicker,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
