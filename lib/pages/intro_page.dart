import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson/components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 25,
                ),

                // app name
                Text(
                  "Flutter Lesson",
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28, color: Colors.white),
                ),
                const SizedBox(
                  height: 25,
                ),

                // icon
                Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Image.asset('lib/images/online-lesson.png')),
                const SizedBox(
                  height: 25,
                ),

                // title
                Text("Learn Flutter and Dart",
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 44, color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),

                // subtitle
                Text("Learn Flutter and Dart to create Android and IOS apps",
                    style: GoogleFonts.dmSerifDisplay(
                        height: 3, color: Color.fromRGBO(105, 105, 105, 1))),
                const SizedBox(
                  height: 25,
                ),
                // get started button

                MyButton(
                  text: "Get Started",
                  onTap: () {
                    // go to list page
                    Navigator.pushNamed(context, '/listpage');
                  },
                )
              ])),
    );
  }
}
