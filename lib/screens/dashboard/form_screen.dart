import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../models/student_entry.dart';
import '../../models/student_repository.dart';
import 'dashboard_screen.dart';

class FormScreen extends StatefulWidget {
  /// True when this is the very first entry right after login (in which
  /// case we replace this screen with the Dashboard once saved).
  /// False when opened from the Dashboard's "Add Student" action (in which
  /// case we just pop back to the Dashboard once saved).
  final bool isFirstEntry;

  const FormScreen({super.key, this.isFirstEntry = true});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return;

    setState(() {
      _pickedImage = File(image.path);
    });
  }

  /// Copies the picked image out of the picker's temporary cache and into
  /// the app's own documents directory, so it's actually persisted on the
  /// device instead of living somewhere the OS can clear at any time.
  Future<String> _persistImage(File source) async {
    final appDir = await getApplicationDocumentsDirectory();
    final studentImagesDir = Directory(p.join(appDir.path, 'student_photos'));
    if (!await studentImagesDir.exists()) {
      await studentImagesDir.create(recursive: true);
    }

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(source.path)}';
    final savedFile =
    await source.copy(p.join(studentImagesDir.path, fileName));
    return savedFile.path;
  }

  Future<void> _submit() async {
    final name = nameController.text.trim();
    final rollNo = rollNoController.text.trim();

    if (name.isEmpty || rollNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter name and roll no.")),
      );
      return;
    }

    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a photo.")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final savedImagePath = await _persistImage(_pickedImage!);

      final entry = StudentEntry(
        name: name,
        rollNo: rollNo,
        imagePath: savedImagePath,
      );

      await StudentRepository.instance.addEntry(entry);

      if (!mounted) return;

      if (widget.isFirstEntry) {
        // Coming straight from login: replace this screen with the Dashboard.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        // Opened from the Dashboard's "Add Student" action: just go back.
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    rollNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Entry"),
        backgroundColor: const Color(0xff173A70),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "New Entry",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff173A70),
                ),
              ),
              const SizedBox(height: 24),

              /// Image picker preview
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 160,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border:
                      Border.all(color: const Color(0xff173A70), width: 2),
                    ),
                    child: _pickedImage == null
                        ? const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey,
                      ),
                    )
                        : ClipRRect(
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Upload Photo"),
                ),
              ),

              const SizedBox(height: 24),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Student Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: rollNoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff173A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: _isSaving ? null : _submit,
                  child: _isSaving
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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