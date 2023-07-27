import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trippy/models/CourseList.dart';
import 'package:trippy/CourseDetail.dart';

class FourthSlidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var courseList = Provider.of<CourseList>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 100,
            child: Image.asset('assets/images/line.png'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Your Booking',
              style: TextStyle(
                fontFamily: "Dmsans",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: courseList.courses.length,
            itemBuilder: (context, index) {
              var dayCourses = courseList.courses[index];

              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetail(
                          course: dayCourses,
                          title: 'Your Course Detail',
                          dayIndex: index,
                          index: 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 220.0,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              dayCourses[0].img,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(),
                              child: Container(
                                width: 450,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8, top: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 4, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/place.png',
                                              width: 15,
                                              height: 15,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              "Busan",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: "Dmsans",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            Image.asset(
                                              'assets/images/date.png',
                                              width: 15,
                                              height: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "July 18", // You might want to replace this with actual date
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: "Dmsans",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
