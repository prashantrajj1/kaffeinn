import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../facecard/face_card_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool scanned = false;
  bool flashOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _openFaceCard() {
    if (scanned) return;

    scanned = true;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => FaceCardScreen(
          mealName: "Lunch",
          studentName: "Prashant Kumar",
          rollNo: "ucsc24042",
          isVeg: true,
          backgroundColor: Colors.red,
          imagePath: "assets/images/prashant.jpg",
        ),
      ),
    );
  }

  Widget _corner(bool left, bool top) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          left: left
              ? const BorderSide(color: Colors.red, width: 5)
              : BorderSide.none,
          right: !left
              ? const BorderSide(color: Colors.red, width: 5)
              : BorderSide.none,
          top: top
              ? const BorderSide(color: Colors.red, width: 5)
              : BorderSide.none,
          bottom: !top
              ? const BorderSide(color: Colors.red, width: 5)
              : BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Scan Now",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    _openFaceCard();
                  },
                ),

                SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    children: [
                      Positioned(top: 0, left: 0, child: _corner(true, true)),
                      Positioned(top: 0, right: 0, child: _corner(false, true)),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: _corner(true, false),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: _corner(false, false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          const Text("Scan a code", style: TextStyle(fontSize: 22)),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(170, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              await controller.toggleTorch();

              setState(() {
                flashOn = !flashOn;
              });
            },
            child: Text(
              "Flash: $flashOn",
              style: const TextStyle(fontSize: 18),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(170, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              scanned = false;
              controller.start();
            },
            child: const Text("resume", style: TextStyle(fontSize: 18)),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
