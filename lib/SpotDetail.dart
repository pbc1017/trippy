import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';

class SpotDetail extends StatelessWidget {
  final Course course;

  SpotDetail({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80.0),  // Increase top padding
            child: Text(course.detail),
          ),
          SafeArea(
            child: BackButton(color: Colors.black),  // Change icon color to black
          ),
        ],
      ),
    );
  }
}
