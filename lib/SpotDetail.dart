import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';

class SpotDetail extends StatelessWidget {
  final Course course;
  final int detailType;
  

  SpotDetail({Key? key, required this.course, required this.detailType}) : super(key: key);

  List<Widget> _buildButtons() {
    if (detailType == 0) {
      return [
        ElevatedButton(onPressed: () {}, child: Text('삭제하기')),
        ElevatedButton(onPressed: () {}, child: Text('장소 변경하기')),
      ];
    } else if (detailType == 1) {
      return [ElevatedButton(onPressed: () {}, child: Text('이 장소로 변경하기'))];
    } else if (detailType == 2) {
      return [ElevatedButton(onPressed: () {}, child: Text('이 장소 추가하기'))];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80.0),  // Increase top padding
            child: Column(
              children: [
                Text('Name: ${course.name}'),
                Image.network(course.img),
                Text('Call: ${course.call}'),
                Text('One-liner: ${course.oneliner}'),
                Text('Detail: ${course.detail}'),
                Text('Is Park: ${course.isPark}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildButtons(),
                ),
              ],
            ),
          ),
          SafeArea(
            child: BackButton(color: Colors.black),  // Change icon color to black
          ),
        ],
      ),
    );
  }
}
