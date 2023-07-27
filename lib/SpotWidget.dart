import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/SpotDetail.dart';

class SpotWidget extends StatefulWidget {
  final List<Course> course;
  final int index;
  final int courseNum;
  final int totalIndex;
  final int detailType;

  SpotWidget({Key? key, required this.course, required this.index, required this.courseNum, required this.totalIndex, required this.detailType}) : super(key: key);

  @override
  _SpotWidgetState createState() => _SpotWidgetState();
}

class _SpotWidgetState extends State<SpotWidget> {

  @override
  Widget build(BuildContext context) {
    String spotType = '';
    if (widget.course[widget.index].id.contains("travel")) {
      spotType = '여행지';
    } else if (widget.course[widget.index].id.contains("food")) {
      spotType = '음식점';
    } else {
      spotType = '숙소';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpotDetail(course: widget.course, index: widget.index, courseNum: widget.courseNum, totalIndex: widget.totalIndex, detailType: widget.detailType),  // detailType is 0 as an example
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top:2, bottom: 2, left:1, right:1),  
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
                        widget.course[widget.index].img,
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
                      Text(widget.course[widget.index].name, style: TextStyle(color: Colors.black87, fontFamily: "Air",fontWeight: FontWeight.w700, fontSize: 14),),
                      SizedBox(height: 2.0),
                      Text(spotType, style: TextStyle(color: Colors.black54, fontFamily: "Dmsans",fontWeight: FontWeight.w300, fontSize: 14),),
                      SizedBox(height: 2.0),
                      Text(widget.course[widget.index].oneliner, style: TextStyle(fontFamily: "Dmsans",fontWeight: FontWeight.w500, fontSize: 14),),
                      SizedBox(height: 2.0),
                      Text(widget.course[widget.index].call,style: TextStyle(fontFamily: "Dmsans",fontWeight: FontWeight.w500, fontSize: 14),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
