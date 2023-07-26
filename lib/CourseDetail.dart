import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trippy/models/CourseList.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/SpotWidget.dart';
import 'package:trippy/main.dart';

import 'SpotSearch.dart';

class CourseDetail extends StatefulWidget {
  final int dayIndex; 
  final List<Course> course;
  final String title;

  CourseDetail({Key? key, required this.dayIndex, required this.course, required this.title}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<Course> day1Courses = [];
  List<Course> day2Courses = [];
  List<Course> day3Courses = [];

  @override
  void initState() {
    super.initState();
    day1Courses = widget.course.where((course) => course.cluster == 0).toList();
    day2Courses = widget.course.where((course) => course.cluster == 1).toList();
    day3Courses = widget.course.where((course) => course.cluster == 2).toList();
  }

  @override
  Widget build(BuildContext context) {
    var favoriteCourseIndex = context.watch<FavoriteCourseIndex>();
  bool _isFavorited = favoriteCourseIndex.favoriteDayIndex == widget.dayIndex;
// ...
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 24)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isFavorited) {
                            favoriteCourseIndex.clearFavoriteIndex();
                          } else {
                            favoriteCourseIndex.setFavoriteIndex(widget.dayIndex,0);
                          }
                        });
                      },
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? Colors.red : Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text("1일차"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotSearch(courses: day1Courses, type: "all"),
                    ),
                  );
                },
                child: const Text('추가'),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: day1Courses.length,
                itemBuilder: (context, index) {
                  return SpotWidget(
                    key: Key(day1Courses[index].id),
                    course: day1Courses[index],
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Course item = day1Courses.removeAt(oldIndex);
                    day1Courses.insert(newIndex, item);
                    context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);  // Add this line
                  });
                },
              ),
              const Text("2일차"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotSearch(courses: day1Courses, type: "all"),
                    ),
                  );
                },
                child: const Text('추가'),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: day2Courses.length,
                itemBuilder: (context, index) {
                  return SpotWidget(
                    key: Key(day2Courses[index].id),
                    course: day2Courses[index],
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Course item = day2Courses.removeAt(oldIndex);
                    day2Courses.insert(newIndex, item);
                    context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);  // Add this line
                  });
                },
              ),
              const Text("3일차"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotSearch(courses: day1Courses, type: "all"),
                    ),
                  );
                },
                child: const Text('추가'),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: day3Courses.length,
                itemBuilder: (context, index) {
                  return SpotWidget(
                    key: Key(day3Courses[index].id),
                    course: day3Courses[index],
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Course item = day3Courses.removeAt(oldIndex);
                    day3Courses.insert(newIndex, item);
                    context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);  // Add this line
                  });
                },
              ),
            ],
          ),
          SafeArea(
            child: BackButton(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
