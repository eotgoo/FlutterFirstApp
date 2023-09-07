// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/lesson.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final void Function()? onTap;
  final void Function()? onDelete;
  final void Function()? onEdit;
  const LessonTile({
    super.key,
    required this.lesson,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(25),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            lesson.imgPath,
            height: 60,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              Text(
                lesson.name,
                style: GoogleFonts.dmSerifDisplay(
                    fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    lesson.rating,
                    style: const TextStyle(
                        color: Color.fromRGBO(105, 105, 105, 1)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: onDelete,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
