import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson/pages/list_page.dart';
import 'package:lesson/pages/start_lesson.dart';
import 'pages/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      getPages: [
        GetPage(name: '/intropage', page: () => const IntroPage()),
        GetPage(name: '/listpage', page: () => const ListPage()),
        GetPage(name: '/lessonpage', page: () => const StartLessonPage()),
      ],
    );
  }
}
