import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trippy/models/CourseList.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/SpotWidget.dart';
import 'package:trippy/main.dart';

import 'SpotSearch.dart';

class CourseDetail extends StatefulWidget {
  final int dayIndex; 
  final int index;
  final int courseNum;
  final int totalIndex;
  final List<Course> course;
  final String title;

  CourseDetail({Key? key, required this.dayIndex, required this.course, required this.courseNum,required this.totalIndex, required this.title, required this.index}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<Course> day1Courses = [];
  List<Course> day2Courses = [];
  List<Course> day3Courses = [];

  // @override
  // void initState() {
  //   super.initState();
  //   day1Courses = widget.course.where((course) => course.cluster == 0).toList();
  //   day2Courses = widget.course.where((course) => course.cluster == 1).toList();
  //   day3Courses = widget.course.where((course) => course.cluster == 2).toList();
  // }

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
  return Consumer<CourseList>(
    builder: (context, courseList, child) {
      var favoriteCourseIndex = context.watch<FavoriteCourseIndex>();
      bool _isFavorited = favoriteCourseIndex.favoriteDayIndex == widget.dayIndex;

      List<Course> day1Courses = widget.course.where((course) => course.cluster == 0).toList();
      List<Course> day2Courses = widget.course.where((course) => course.cluster == 1).toList();
      List<Course> day3Courses = widget.course.where((course) => course.cluster == 2).toList();

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.green,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(
                    day1Courses.isNotEmpty ? day1Courses[0].img : 'https://a.cdn-hotels.com/gdcs/production75/d1444/e66988b1-f783-4e8f-a7ea-8c5eebe88436.jpg?impolicy=fcrop&w=800&h=533&q=medium', 
                    fit: BoxFit.cover
                ),
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
                  // Always return a widget
                  if (index < 3) {
                    List<Course> courses;
                    if (index == 0) {
                      courses = day1Courses;
                    } else if (index == 1) {
                      courses = day2Courses;
                    } else {
                      courses = day3Courses;
                    }
                    return _buildReorderableList(index, courses);
                  } else {
                    return Container();  // Empty container for extra indices
                  }
                },
                childCount: 3,  // Always return 3 children
              ),
            ),
          ],
        ),
      );
    },
  );
}


  Widget _buildReorderableList(int dayIndex, List<Course> dayCourses) {
  return Column(
    children: [
      _buildDayHeader(dayIndex, dayCourses),
      dayCourses.isNotEmpty
        ? ReorderableListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dayCourses.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildSpotWidget(dayCourses, index, dayIndex, index);
            },
            onReorder: (oldIndex, newIndex) {
              _reorderDayCourses(dayIndex, dayCourses, oldIndex, newIndex);
            },
          )
        : Container(height: 0),  // An empty container of a certain height
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
          Row(  // Wrap the buttons into a Row
            children: <Widget>[
              FloatingActionButton(
                heroTag: "addButton$dayIndex",  // Add unique heroTag
                mini: true, 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotSearch(courses: dayCourses, detailType: 2, courseNum: widget.courseNum, totalIndex:widget.totalIndex, type: "all"),
                    ),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.green,
              ),
              SizedBox(width: 10),  // provide some spacing between the buttons
              FloatingActionButton(
                heroTag: "reserveButton$dayIndex",  // Add unique heroTag
                mini: true,
                onPressed: () {
                  // TODO: add your code for reservation action here
                },
                child: const Icon(Icons.calendar_today),  // for example, using calendar icon for reservation button
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  Widget _buildSpotWidget(List<Course> dayCourses, int index, int day, int totalIndex) {
    if (day == 1) {
      totalIndex += day2Courses.length;
    }
    else if (day == 2) {
      totalIndex = totalIndex + day2Courses.length + day3Courses.length;
    }
    return SpotWidget(
      key: Key(dayCourses[index].id),
      course: dayCourses,
      index: index,
      courseNum: widget.dayIndex,
      totalIndex: totalIndex,
      detailType: 0,
    );
  }
}
