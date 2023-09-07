// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, avoid_print, dead_code, unused_label, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson/components/edit_list_dialog.dart';
import 'package:lesson/components/lesson_tile.dart';
import 'package:lesson/models/lesson.dart';
import 'package:lesson/components/add_list_dialog.dart';
import 'package:lesson/pages/lesson_details.dart';
import 'package:lesson/theme/colors.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ScrollController _scrollController = ScrollController();
  DocumentSnapshot? lastVisible;

  void _showAddListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddListDialog();
      },
    );
  }

  void showEditDialog(DocumentSnapshot lessonSnapshot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditListDialog(
          lessonSnapshot: lessonSnapshot,
        );
      },
    );
  }

  late CollectionReference lessonsCollection;

  @override
  void initState() {
    super.initState();
    lessonsCollection = FirebaseFirestore.instance.collection('Lessons');

    // Add an event listener for scrolling to the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data here
        _loadMoreData();
      }
    });

    // Initial query
    _loadInitialData();
  }

  void _loadInitialData() async {
    QuerySnapshot querySnapshot = await lessonsCollection
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      lastVisible = querySnapshot.docs.last;
      // Update your UI with the initial data
      setState(() {
        // Update your UI with querySnapshot.docs
      });
    }
  }

  void _loadMoreData() async {
    if (lastVisible != null) {
      QuerySnapshot querySnapshot = await lessonsCollection
          .orderBy("createdAt", descending: true)
          .startAfterDocument(lastVisible!)
          .limit(10)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastVisible = querySnapshot.docs.last;
        // Append the new data to your UI
        setState(() {
          // Append querySnapshot.docs to your existing data
        });
      }
    }
  }

  // naviage to details page

  void navigateToLessonDetails(DocumentSnapshot lessonSnapshot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonDetailsPage(
            lesson: Lesson(
                name: lessonSnapshot['name'],
                imgPath: lessonSnapshot['imgPath'],
                rating: lessonSnapshot['rating'],
                description: lessonSnapshot['description'])),
      ),
    );
  }

  Future<void> deleteLesson(DocumentSnapshot lessonSnapshot) async {
    try {
      await lessonSnapshot.reference.delete();
    } catch (e) {
      print('deleting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Text(
          'Flutter',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          // Add button
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              _showAddListDialog();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // banner
          Container(
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //hello
                    Text(
                      'Hello',
                      style: GoogleFonts.dmSerifDisplay(
                          fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 140,
                      child: Text("Today is a good day to learn something new!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(105, 105, 105, 1),
                            height: 1,
                          )),
                    )
                  ],
                ),
                // image
                Image.asset(
                  'lib/images/programming.png',
                  height: 100,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Search here.."),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Lesson",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(105, 105, 105, 1),
                  fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // popular lessons
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(25),
            child: StreamBuilder<QuerySnapshot>(
              stream: lessonsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final lessonDocs = snapshot.data!.docs;
                return ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: lessonDocs.length,
                  itemBuilder: (context, index) {
                    final lessonData =
                        lessonDocs[index].data() as Map<String, dynamic>;
                    final lesson = Lesson(
                        name: lessonData['name'],
                        imgPath: lessonData['imgPath'],
                        rating: lessonData['rating'],
                        description: '');
                    return LessonTile(
                      lesson: lesson,
                      onTap: () => navigateToLessonDetails(lessonDocs[index]),
                      onDelete: () => deleteLesson(lessonDocs[index]),
                      onEdit: () => showEditDialog(lessonDocs[index]),
                    );
                  },
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
