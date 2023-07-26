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

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(day1Courses[0].img),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.8), BlendMode.srcOver),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.white)
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    
                    // Repeat for each day
                  // Repeat for each day
                    for (var i = 0; i < 3; i++)
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                color: Colors.grey[200],
                                height: 70,  // adjust as needed
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Day $i"),
                                    FloatingActionButton(
                                      mini: true, 
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SpotSearch(courses: day1Courses, type: "all"),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.add),
                                      backgroundColor: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);
                              });
                            },
                          ),
                        ],
                      ),


                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
