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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(day1Courses[0].img, fit: BoxFit.cover),
                title: Text(widget.title),
                centerTitle: true, // Title 가운데 정렬 추가
                titlePadding: EdgeInsets.only(bottom: 20), // 좌측 패딩만 제거
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
                // Header for Day 1
                if (index == 0) {
                  return _buildDayHeader(index, day1Courses);
                } 
                // Items for Day 1
                else if (index > 0 && index <= day1Courses.length + 1) {
                  return _buildSpotWidget(day1Courses, index-1);
                }
                // Header for Day 2
                else if (index == day1Courses.length + 2) {
                  return _buildDayHeader(index, day2Courses);
                }
                // Items for Day 2
                else if (index > day1Courses.length + 2 && index <= day1Courses.length + day2Courses.length + 2) {
                  return _buildSpotWidget(day2Courses, index - day1Courses.length - 3);
                }
                // Header for Day 3
                else if (index == day1Courses.length + day2Courses.length + 3) {
                  return _buildDayHeader(index, day3Courses);
                }
                // Items for Day 3
                else if (index > day1Courses.length + day2Courses.length + 3 && index <= day1Courses.length + day2Courses.length + day3Courses.length + 3) {
                  return _buildSpotWidget(day3Courses, index - day1Courses.length - day2Courses.length - 4);
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

  Widget _buildDayHeader(int index, List<Course> dayCourses) {
    return Container(
      color: Colors.grey[200],
      height: 70,  // adjust as needed
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Day ${index + 1}"),
            FloatingActionButton(
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
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dayCourses.length,
      itemBuilder: (context, idx) {
        return SpotWidget(
          key: Key(dayCourses[idx].id),
          course: dayCourses[idx],
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Course item = dayCourses.removeAt(oldIndex);
          dayCourses.insert(newIndex, item);
          context.read<CourseList>().reorderCourses(widget.dayIndex, oldIndex, newIndex);
        });
      },
    );
  }
}
