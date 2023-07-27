import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';

class SpotDetail extends StatelessWidget {
  final Course course;
  final int detailType;
  

  SpotDetail({Key? key, required this.course, required this.detailType}) : super(key: key);

  List<Widget> _buildButtons() {
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.white, // button color
    onPrimary: Colors.green, // text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // button shape
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // padding
    textStyle: TextStyle(fontSize: 18), // text style
  );

  if (detailType == 0) {
    return [
      Container(
        width: 250,
        height: 50,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {},
          child: Text('장소 변경하기'),
        ),
      ),
    ];
  } else if (detailType == 1) {
    return [
      Container(
        width: 250,
        height: 50,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {},
          child: Text('이 장소로 변경하기'),
        ),
      ),
    ];
  } else if (detailType == 2) {
    return [
      Container(
        width: 250,
        height: 50,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {},
          child: Text('이 장소 추가하기'),
        ),
      ),
    ];
  }
  return [];
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.98), // setting the background color to F9F9F9

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 120.0),  // Increase top padding
            child: Column(
              children: [
                Container(
                    height: 300.0, // you can adjust the height as you need
                    width: 300.0, // you can adjust the width as you need
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0), 
                        child: Image.network(
                          course.img,
                          fit: BoxFit.cover, // this is what you need
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${course.name}', 
                      style: TextStyle(fontSize: 24, fontFamily: 'As', fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(height: 16,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      '${course.oneliner}', 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, fontFamily: 'Dmsans', fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 16,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${course.call}', 
                      style: TextStyle(fontSize: 16, fontFamily: 'Dmsans', fontWeight: FontWeight.w500),
                    ),
                  ),
                SizedBox(height: 16,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      '${course.detail}', 
                      style: TextStyle(fontSize: 16, fontFamily: 'Dmsans', fontWeight: FontWeight.w500),
                    ),
                  ),
                SizedBox(height: 16,),
                Text('Is Park: ${course.isPark}'),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildButtons(),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.black),
                if (detailType == 0) 
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.black), // delete icon
                    onPressed: () {
                      // handle delete action here
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
