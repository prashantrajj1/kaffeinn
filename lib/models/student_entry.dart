/// A single saved student entry (name, roll number, and the
/// permanent on-device path of their photo).
class StudentEntry {
  final String name;
  final String rollNo;
  final String imagePath;
  final DateTime createdAt;

  StudentEntry({
    required this.name,
    required this.rollNo,
    required this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}