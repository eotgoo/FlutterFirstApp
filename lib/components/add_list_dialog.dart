// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddListDialog extends StatefulWidget {
  @override
  _AddListDialogState createState() => _AddListDialogState();
}

class _AddListDialogState extends State<AddListDialog> {
  TextEditingController lessonNameController = TextEditingController();
  TextEditingController lessonImagePathController = TextEditingController();
  TextEditingController lessonRatingController = TextEditingController();
  TextEditingController lessonDescriptionController = TextEditingController();

  void _addNewLesson() {
    String name = lessonNameController.text;
    String imgPath = lessonImagePathController.text;
    String rating = lessonRatingController.text;
    String description = lessonDescriptionController.text;

    if (name.isNotEmpty && imgPath.isNotEmpty) {
      // Add new lesson
      FirebaseFirestore.instance.collection('Lessons').add({
        'name': name,
        'imgPath': imgPath,
        'rating': rating,
        'description': description,
      });

      // Close
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Lesson'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: lessonNameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: lessonImagePathController,
              decoration: const InputDecoration(labelText: 'Image Path'),
            ),
            TextField(
              controller: lessonRatingController,
              decoration: const InputDecoration(labelText: 'Rating'),
            ),
            TextField(
              controller: lessonDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Add',
            style: TextStyle(color: Colors.blue[900]),
          ),
          onPressed: () {
            _addNewLesson();
          },
        ),
      ],
    );
  }
}
