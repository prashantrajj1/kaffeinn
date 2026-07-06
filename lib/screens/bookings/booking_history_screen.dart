import 'package:flutter/material.dart';
import '../../models/student_repository.dart';
import '../../widgets/app_drawer.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = StudentRepository.instance.entries.isNotEmpty
        ? StudentRepository.instance.entries.first
        : null;

    return Scaffold(
      backgroundColor: const Color(0xffFFF9FE), // Light pinkish background from screenshot
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Booking History",
          style: TextStyle(color: Colors.black87, fontSize: 22),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        name: student?.name ?? "Prashant Kumar",
        rollNo: student?.rollNo ?? "ucsc24042",
        imagePath: student?.imagePath,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: DataTable(
              columnSpacing: 40,
              headingRowHeight: 60,
              dataRowMinHeight: 70,
              dataRowMaxHeight: 70,
              dividerThickness: 1,
              horizontalMargin: 10,
              columns: [
                _buildHeader("Date"),
                _buildHeader("Breakfast"),
                _buildHeader("Lunch"),
                _buildHeader("Dinner"),
              ],
              rows: [
                _buildRow("2026-07-07", "Not\nBooked", "Booked\n12:00 AM", "Not\nBooked"),
                _buildRow("2026-07-06", "Confirmed\n08:57 AM", "Booked\n12:00 AM", "Booked\n12:00 AM"),
                _buildRow("2026-07-05", "Confirmed\n09:15 AM", "Confirmed\n01:39 PM", "Not\nBooked"),
                _buildRow("2026-07-03", "Confirmed\n09:15 AM", "Confirmed\n12:56 PM", "Confirmed\n09:01 PM"),
                _buildRow("2026-07-01", "Confirmed\n08:15 AM", "Confirmed\n12:46 PM", "Confirmed\n09:01 PM"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _buildHeader(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFE97451), // Burnt sienna / Coral color from image
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  DataRow _buildRow(String date, String breakfast, String lunch, String dinner) {
    return DataRow(
      cells: [
        DataCell(Text(date, style: const TextStyle(color: Colors.black87))),
        DataCell(_buildStatusCell(breakfast)),
        DataCell(_buildStatusCell(lunch)),
        DataCell(_buildStatusCell(dinner)),
      ],
    );
  }

  Widget _buildStatusCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.3),
      ),
    );
  }
}
