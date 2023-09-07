// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson/components/button.dart';
import 'package:lesson/models/lesson.dart';
import 'package:lesson/theme/colors.dart';

class LessonDetailsPage extends StatefulWidget {
  final Lesson lesson;
  const LessonDetailsPage({super.key, required this.lesson});

  @override
  State<LessonDetailsPage> createState() => _LessonDetailsPageState();
}

class _LessonDetailsPageState extends State<LessonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // listview of lesson details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  // image
                  Image.asset(
                    widget.lesson.imgPath,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // rating

                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.lesson.rating,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(105, 105, 105, 1),
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // name

                  Text(
                    widget.lesson.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  // description
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Description",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(105, 105, 105, 1),
                          fontSize: 18)),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.lesson.description,
                    style: TextStyle(
                        color: Color.fromRGBO(80, 80, 80, 1),
                        fontSize: 14,
                        height: 2),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                MyButton(
                  text: "START",
                  onTap: () {
                    // go to start lesson
                    Navigator.pushNamed(context, '/lessonpage');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
