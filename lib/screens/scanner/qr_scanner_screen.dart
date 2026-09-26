import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'meal_approved_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() =>
      _QRScannerScreenState();
}

class _QRScannerScreenState
    extends State<QRScannerScreen> {
  final MobileScannerController controller =
      MobileScannerController();

  bool scanned = false;
  bool flashOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQRDetected(BarcodeCapture capture) {
    if (scanned) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final barcode = capture.barcodes.first;

    final qrValue =
        barcode.rawValue?.trim() ?? '';

    if (qrValue.isEmpty) {
      return;
    }

    scanned = true;

    controller.stop();

    // ----------------------------------------------------------
    // TEMPORARY DEMO DATA
    // ----------------------------------------------------------
    //
    // We will connect this to your actual student database
    // after the new UI is working correctly.
    //
    // For now, scanning ANY valid QR code will show:
    //
    // Manish Ghaturay
    // UCESE2406
    //
    // ----------------------------------------------------------

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MealApprovedScreen(
          studentName: 'Manish Ghaturay',
          rollNo: 'UCESE2406',
          mealType: 'Dinner',
        ),
      ),
    );
  }

  Widget _scanCorner({
    required bool left,
    required bool top,
  }) {
    return SizedBox(
      width: 45,
      height: 45,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: left
                ? const BorderSide(
                    color: Colors.white,
                    width: 5,
                  )
                : BorderSide.none,

            right: !left
                ? const BorderSide(
                    color: Colors.white,
                    width: 5,
                  )
                : BorderSide.none,

            top: top
                ? const BorderSide(
                    color: Colors.white,
                    width: 5,
                  )
                : BorderSide.none,

            bottom: !top
                ? const BorderSide(
                    color: Colors.white,
                    width: 5,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(
          children: [
            // =====================================================
            // CAMERA
            // =====================================================

            Positioned.fill(
              child: MobileScanner(
                controller: controller,
                onDetect: _onQRDetected,
              ),
            ),

            // =====================================================
            // DARK OVERLAY
            // =====================================================

            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
            ),

            // =====================================================
            // TOP BAR
            // =====================================================

            Positioned(
              top: 10,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.50),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    'Scan Meal QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.50),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await controller.toggleTorch();

                        if (!mounted) {
                          return;
                        }

                        setState(() {
                          flashOn = !flashOn;
                        });
                      },
                      icon: Icon(
                        flashOn
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // QR SCANNING FRAME
            // =====================================================

            Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _scanCorner(
                        left: true,
                        top: true,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: _scanCorner(
                        left: false,
                        top: true,
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: _scanCorner(
                        left: true,
                        top: false,
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _scanCorner(
                        left: false,
                        top: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // SCAN INSTRUCTION
            // =====================================================

            Positioned(
              left: 25,
              right: 25,
              bottom: 35,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.70),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.qr_code_2,
                      color: Colors.white,
                      size: 38,
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Scan the meal QR code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Place the QR code inside the frame',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
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
}