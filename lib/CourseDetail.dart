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

  void _reorderDayCourses(int dayIndex, List<Course> dayCourses, int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Course course = dayCourses.removeAt(oldIndex);
      dayCourses.insert(newIndex, course);
      if (dayIndex == 1) {
        oldIndex += day1Courses.length;
        newIndex += day1Courses.length;
      }
      else if (dayIndex == 2) {
        oldIndex = oldIndex + day1Courses.length+ day2Courses.length;
        newIndex = newIndex + day1Courses.length+ day2Courses.length;
      }
      context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);  // use dayIndex here
    });
  }

  @override
  Widget build(BuildContext context) {
    var favoriteCourseIndex = context.watch<FavoriteCourseIndex>();
    bool _isFavorited = favoriteCourseIndex.favoriteDayIndex == widget.dayIndex;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.network(day1Courses[0].img, fit: BoxFit.cover),
              title: Text(widget.title),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    if (_isFavorited) {
                      favoriteCourseIndex.clearFavoriteIndex();
                    } else {
                      favoriteCourseIndex.setFavoriteIndex(widget.dayIndex, 0);
                    }
                  });
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // print(index);
                // List for Day 1
                if (index == 0) {
                  return _buildReorderableList(index, day1Courses);
                } 
                // List for Day 2
                else if (index == 1) {
                  return _buildReorderableList(index, day2Courses);
                }
                // List for Day 3
                else if (index == 2) {
                  return _buildReorderableList(index, day3Courses);
                }
                // End of List
                else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReorderableList(int dayIndex, List<Course> dayCourses) {
    return Column(
      children: [
        _buildDayHeader(dayIndex, dayCourses),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dayCourses.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildSpotWidget(dayCourses, index);
          },
          onReorder: (oldIndex, newIndex) {
            _reorderDayCourses(dayIndex, dayCourses, oldIndex, newIndex);  // pass dayCourses directly
          },
        ),
      ],
    );
  }

  Widget _buildDayHeader(int dayIndex, List<Course> dayCourses) {
  return Container(
    color: Colors.grey[200],
    height: 70,  // adjust as needed
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Day ${dayIndex+1}"),
          FloatingActionButton(
            heroTag: "addButton$dayIndex",  // Add unique heroTag
            mini: true, 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpotSearch(courses: dayCourses, type: "all"),
                ),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    ),
  );
}

  Widget _buildSpotWidget(List<Course> dayCourses, int index) {
    return SpotWidget(
      key: Key(dayCourses[index].id),
      course: dayCourses[index],
    );
  }
}
