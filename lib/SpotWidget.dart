import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/spotDetail.dart';

class SpotWidget extends StatelessWidget {
  final Course course;

  SpotWidget({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String spotType = '';
    if (course.id.contains("travel")) {
      spotType = '여행지';
    } else if (course.id.contains("food")) {
      spotType = '음식점';
    } else {
      spotType = '숙소';
    }

    return ListTile(
      leading: Image.network(course.img),
      title: Text(course.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(spotType),
          Text(course.oneliner),
          Text(course.call),
          Text(course.isPark),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpotDetail(course: course),
          ),
        );
      },
    );
  }
}