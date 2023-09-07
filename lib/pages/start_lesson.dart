// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StartLessonPage extends StatefulWidget {
  const StartLessonPage({super.key});

  @override
  State<StartLessonPage> createState() => _StartLessonPageState();
}

class _StartLessonPageState extends State<StartLessonPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _controller;

  List<Map<String, dynamic>> steps = [
    {
      'title': 'Step 1:',
      'content':
          'Go to pubspec.yaml file, and add the following line replacing [latest_version] with the latest version of the package, and run flutter pub get:',
      'p': 'youtube_player_flutter: [latest_version]'
    },
    {
      'title': 'Step 2:',
      'content':
          'For Android, make sure that the minSdkVersion inside android/app/build.gradle file is to at least 17.',
      'p': ''
    },
    {
      'title': 'Step 3:',
      'content':
          'Create YoutubePlayerController with the id of the video you want to play. So, for example, if want to play this video (https://youtube.com/watch?v=-BYWbosiYlw), the videoId would be “-BYWbosiYlw”.',
      'p': 'YoutubePlayerController _controller;'
    },
    {
      'title': 'Step 4:',
      'content':
          'Use YoutubePlayer widget and provide the controller that we just created as follows:',
      'p':
          '_controller = YoutubePlayerController(initialVideoId: -BYWbosiYlw,flags: YoutubePlayerFlags(autoPlay: true,mute: true,),);'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = YoutubePlayerController(
      initialVideoId: 'M5XD4Do6zss',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: [
            Tab(text: 'Video'),
            Tab(text: 'Read'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(() {});
                },
              ),
              builder: (context, player) => player,
            ),
          ),
          ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[index]['title'],
                          style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          steps[index]['content'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(105, 105, 105, 1),
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          steps[index]['p'],
                          style: TextStyle(
                              color: Color.fromRGBO(80, 80, 80, 1),
                              fontSize: 14,
                              height: 2),
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StartLessonPage(),
  ));
}
