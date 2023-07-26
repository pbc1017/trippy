import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/CourseWidget.dart';
import 'package:trippy/models/CourseList.dart';
import 'package:provider/provider.dart';
import 'package:trippy/main.dart';

import 'CourseDetail.dart';

class CourseWidget extends StatefulWidget {
  final int dayIndex; 
  final int index;
  final String title;  // <-- Add this line

  const CourseWidget({Key? key, required this.dayIndex, required this.index, required this.title}) : super(key: key);  // <-- Modify this line

  @override
  _CourseWidgetState createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    var courseList = Provider.of<CourseList>(context);
    var favoriteCourseIndex = Provider.of<FavoriteCourseIndex>(context);
    final List<Course> course = courseList.courses[widget.dayIndex];

    bool _isFavorited = favoriteCourseIndex.favoriteDayIndex == widget.dayIndex && favoriteCourseIndex.favoriteIndex == widget.index;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetail(course: course, title: widget.title, dayIndex: widget.dayIndex,),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: <Widget>[
            Container(
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(course[0].img), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isFavorited) {
                      favoriteCourseIndex.clearFavoriteIndex();
                    } else {
                      favoriteCourseIndex.setFavoriteIndex(widget.dayIndex, widget.index);
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
          ]),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,  // <-- Modify this line
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("4.7",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              )
            ],
          ),
          Text(
            'Busan',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          // Text('',
          //     style: const TextStyle(
          //         fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
          // Row(
          //   children: [
          //     Text('기장 · 광안리 · 해운대',
          //         style: const TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //         )),
          //     // const Text(' night',
          //     //     style: TextStyle(
          //     //       fontSize: 16,
          //     //       fontWeight: FontWeight.w400,
          //     //     ))
          //   ],
          // )
        ],
      )
    );
  }
}
