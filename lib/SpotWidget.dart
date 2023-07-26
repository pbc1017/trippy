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

    return Padding(
      padding: EdgeInsets.only(top:2, bottom: 2, left:1, right:1),  // add this line, adjust the padding value as you need
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 100,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(5),
              child: Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      course.img,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.0),
                    Text(course.name, style: TextStyle(color: Colors.black87, fontFamily: "Dmsans",fontWeight: FontWeight.w700, fontSize: 14),),
                    SizedBox(height: 2.0),
                    Text(spotType, style: TextStyle(color: Colors.black54, fontFamily: "Dmsans",fontWeight: FontWeight.w300, fontSize: 14),),
                    SizedBox(height: 2.0),
                    Text(course.oneliner, style: TextStyle(fontFamily: "Dmsans",fontWeight: FontWeight.w500, fontSize: 14),),
                    SizedBox(height: 2.0),
                    Text(course.call,style: TextStyle(fontFamily: "Dmsans",fontWeight: FontWeight.w500, fontSize: 14),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
