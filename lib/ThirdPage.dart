import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'SpotDetail.dart';
import 'main.dart';
import 'models/CourseList.dart';
import 'package:provider/provider.dart';
import 'models/tripCourse.dart';

enum ButtonType {
  coffee,
  store,
  carpark,
}

class ThirdPage extends StatefulWidget{
  const ThirdPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>{
  late KakaoMapController mapController;

  Set<Marker> markers = {};
  ButtonType buttonType = ButtonType.coffee;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<List<String>> pinUrls = [
      ["https://i.ibb.co/MDFWC8D/pin-3.png",
      "https://i.ibb.co/gZ1GCvR/pin.png",
      "https://i.ibb.co/gt1q0fY/pin-1.png",
      "https://i.ibb.co/myYTCGC/pin-2.png",
      "https://i.ibb.co/p4T20wY/pin-15.png",
      "https://i.ibb.co/644XK28/pin-16.png",
      "https://i.ibb.co/4KmFQNq/pin-4.png",
      "https://i.ibb.co/93hHbhZ/pin-5.png"],
      ["https://i.ibb.co/hKb9ZpD/pin-21.png",
      "https://i.ibb.co/nmsg4kM/pin-12.png",
      "https://i.ibb.co/k0z585T/pin-13.png",
      "https://i.ibb.co/RgKwZv4/pin-14.png",
      "https://i.ibb.co/M1s6TCs/pin-19.png",
      "https://i.ibb.co/3FRV1Qf/pin-20.png",
      "https://i.ibb.co/vYw18QZ/pin-22.png",
      "https://i.ibb.co/ygLVgV2/pin-23.png"],
      ["https://i.ibb.co/KyT7HN0/pin-9.png",
      "https://i.ibb.co/Ksf9nrf/pin-6.png",
      "https://i.ibb.co/Fb5f5yy/pin-7.png",
      "https://i.ibb.co/CHrZhSH/pin-8.png",
      "https://i.ibb.co/dBpJDgy/pin-17.png",
      "https://i.ibb.co/0KvQMZQ/pin-18.png",
      "https://i.ibb.co/3kXHXct/pin-10.png",
      "https://i.ibb.co/yngCvnj/pin-11.png"]
    ];
    final favoriteCourseIndex = Provider.of<FavoriteCourseIndex>(context);
    final courseList = Provider.of<CourseList>(context);
    List<List<double>> latlng = [[0, 0],[0, 0],[0, 0]];
    List<int> cnt = [0,0,0];
    if (favoriteCourseIndex.favoriteDayIndex>-1) {
      final List<Course> favoriteCourse = courseList.courses[favoriteCourseIndex.favoriteDayIndex];
      var index = 0;
      int thiscluster=0;
      for (var i = 0; i < favoriteCourse.length; i++) {
        var course = favoriteCourse[i];
        String markerImageSrc;
        if (thiscluster != course.cluster) {
          index = 0;
        }
        thiscluster = course.cluster;
        if (course.id.contains("food")) {
          markerImageSrc = pinUrls[course.cluster][6];
        } else if (course.id.contains("hotel")) {
          markerImageSrc = pinUrls[course.cluster][7];
        } else {
          markerImageSrc = pinUrls[course.cluster][index];
          index += 1;
        }
        if(!course.id.contains("hotel")) {
          latlng[course.cluster][0] += course.latitude;
          latlng[course.cluster][1] += course.longitude;
          cnt[course.cluster] += 1;
        }
        markers.add(
          Marker(
            markerImageSrc: markerImageSrc,
            latLng: LatLng(course.latitude, course.longitude),
            markerId: i.toString(),
            width: 40,
            height: 50,
            offsetX: 20,
            offsetY: 50,
          )
        );
      }
      for (var i in [0,1,2]) {
        latlng[i][0] /= cnt[i];
        latlng[i][1] /= cnt[i];
      }
    }
    else {
      latlng = [[35.1379222, 129.11562775],[35.1379222, 129.11562775],[35.1379222, 129.11562775]];
    }
    return Scaffold(
      body: Stack(
        children: [
          KakaoMap(
            onMapCreated: ((controller) async {
              mapController = controller;
              setState(() {});
            }),
            markers: markers.toList(),
            center: LatLng(35.1379222, 129.11562775),
            currentLevel: 9,
            onMarkerTap: (markerId, latLng, zoomLevel) {
              final List<Course> favoriteCourse = courseList.courses[favoriteCourseIndex.favoriteDayIndex];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpotDetail(course: favoriteCourse, index: int.parse(markerId), courseNum: 0, totalIndex: 0, detailType: 0),  // detailType is 0 as an example
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            height: 50.0,
                            onPressed: () {
                              buttonType = ButtonType.coffee;
                              setState(() {});
                              mapController.setCenter(LatLng(latlng[0][0], latlng[0][1]));
                              mapController.setLevel(7);
                            },
                            color: buttonType == ButtonType.coffee ? Colors.green : Colors.white,
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(),
          child: Text('Day 1', style: TextStyle(fontSize: 16.0, color: buttonType == ButtonType.coffee ? Colors.white : Colors.green)),
                                ),
                              ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50.0,
                            onPressed: () {
                              buttonType = ButtonType.store;
                              setState(() {});
                              mapController.setCenter(LatLng(latlng[1][0], latlng[1][1]));
                              mapController.setLevel(7);
                            },
                            color: buttonType == ButtonType.store ? Colors.green : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(),
          child: Text('Day 2', style: TextStyle(fontSize: 16.0, color: buttonType == ButtonType.store ? Colors.white : Colors.green)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50.0,
                            onPressed: () {
                              buttonType = ButtonType.carpark;
                              setState(() {});
                              mapController.setCenter(LatLng(latlng[2][0], latlng[2][1]));
                              mapController.setLevel(7);
                            },
                            color: buttonType == ButtonType.carpark ?Colors.green : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(),
          child: Text('Day 3', style: TextStyle(fontSize: 16.0, color: buttonType == ButtonType.carpark? Colors.white : Colors.green)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}