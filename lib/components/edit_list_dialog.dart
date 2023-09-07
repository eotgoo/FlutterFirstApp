// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditListDialog extends StatefulWidget {
  final DocumentSnapshot lessonSnapshot;

  EditListDialog({required this.lessonSnapshot});

  @override
  _EditListDialogState createState() => _EditListDialogState();
}

class _EditListDialogState extends State<EditListDialog> {
  TextEditingController lessonName = TextEditingController();
  TextEditingController lessonImage = TextEditingController();
  TextEditingController lessonRating = TextEditingController();
  TextEditingController lessonDescription = TextEditingController();

  @override
  void initState() {
    super.initState();

    //lesson data
    lessonName.text = widget.lessonSnapshot['name'];
    lessonImage.text = widget.lessonSnapshot['imgPath'];
    lessonRating.text = widget.lessonSnapshot['rating'];
    lessonDescription.text = widget.lessonSnapshot['description'];
  }

  void _updateLesson() {
    String name = lessonName.text;
    String imgPath = lessonImage.text;
    String rating = lessonRating.text;
    String description = lessonDescription.text;

    if (name.isNotEmpty && imgPath.isNotEmpty) {
      // Update the existing lesson
      widget.lessonSnapshot.reference.update({
        'name': name,
        'imgPath': imgPath,
        'rating': rating,
        'description': description,
      });

      // Close the dialog
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Lesson"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: lessonName,
              decoration: const InputDecoration(labelText: "Lesson Name"),
            ),
            TextField(
              controller: lessonImage,
              decoration: const InputDecoration(labelText: "Image Path"),
            ),
            TextField(
              controller: lessonRating,
              decoration: const InputDecoration(labelText: "Rating"),
            ),
            TextField(
              controller: lessonDescription,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updateLesson,
          child: const Text("Save"),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog without saving any changes
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
