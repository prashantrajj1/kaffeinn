import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'student_entry.dart';

/// Persisted store for submitted entries using SharedPreferences.
class StudentRepository {
  StudentRepository._internal();
  static final StudentRepository instance = StudentRepository._internal();

  List<StudentEntry> _entries = [];
  bool _isInitialized = false;

  /// Newest first.
  List<StudentEntry> get entries => List.unmodifiable(_entries);

  Future<void> init() async {
    if (_isInitialized) return;
    final prefs = await SharedPreferences.getInstance();
    final String? entriesJson = prefs.getString('student_entries');
    if (entriesJson != null) {
      final List<dynamic> decoded = jsonDecode(entriesJson);
      _entries = decoded.map((item) => StudentEntry(
        name: item['name'],
        rollNo: item['rollNo'],
        imagePath: item['imagePath'],
        createdAt: DateTime.parse(item['createdAt']),
      )).toList();
    }
    _isInitialized = true;
  }

  Future<void> addEntry(StudentEntry entry) async {
    await init();
    _entries.insert(0, entry);
    await _save();
  }

  Future<void> removeEntry(StudentEntry entry) async {
    await init();
    _entries.remove(entry);
    await _save();
  }

  Future<void> clear() async {
    _entries.clear();
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_entries.map((e) => {
      'name': e.name,
      'rollNo': e.rollNo,
      'imagePath': e.imagePath,
      'createdAt': e.createdAt.toIso8601String(),
    }).toList());
    await prefs.setString('student_entries', encoded);
  }
}
