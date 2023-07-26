import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
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
    // CourseList.courses[0][0];
    final favoriteCourseIndex = Provider.of<FavoriteCourseIndex>(context);
    final courseList = Provider.of<CourseList>(context);
    List<List<double>> latlng = [[0, 0],[0, 0],[0, 0]];
    List<int> cnt = [0,0,0];
    if (favoriteCourseIndex.favoriteDayIndex>-1) {
      final List<Course> favoriteCourse = courseList.courses[favoriteCourseIndex.favoriteDayIndex];
      // markers.add(Marker(markerImageSrc: pinUrls[0][0],latLng: LatLng(37.499590490909185, 127.0263723554437),markerId: markers.length.toString(),width: 40, height: 50, offsetX:20, offsetY:50,));
      var index = 0;
      int thiscluster=0;
      for (var course in favoriteCourse) {
        String markerImageSrc;
        if (thiscluster != course.cluster) {
          index = 0;
        }
        thiscluster = course.cluster;
        // Determine the index for pinUrls based on the course's id
        // print(course.id);
        if (course.id.contains("food")) {
          markerImageSrc = pinUrls[course.cluster][6];
        } else if (course.id.contains("hotel")) {
          markerImageSrc = pinUrls[course.cluster][7];
        } else {
          // For other cases, determine the index based on the order of the course in the list
          // Use modulus to ensure that index is within the range of pinUrls[course.cluster]
          markerImageSrc = pinUrls[course.cluster][index];
          index += 1;
        }
        if(!course.id.contains("hotel")) {
          latlng[course.cluster][0] += course.latitude;
          latlng[course.cluster][1] += course.longitude;
          cnt[course.cluster] += 1;
        }

        // Add the marker with the determined markerImageSrc and the course's latitude and longitude
        markers.add(
          Marker(
            markerImageSrc: markerImageSrc,
            latLng: LatLng(course.latitude, course.longitude),
            markerId: markers.length.toString(),
            width: 40,
            height: 50,
            offsetX: 20,
            offsetY: 50,
            // infoWindowContent: '<p style="background-color: white; padding: 5px; border-radius: 8px;">${course.name}</p>',
            // infoWindowRemovable: true,
            // infoWindowFirstShow: false,
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
    // print(latlng);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
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
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('marker click:\n\n$latLng')));
              
            },
          ),
          Row(
            children: [
              MaterialButton(
                onPressed: () {
                  buttonType = ButtonType.coffee;
                  setState(() {});
                  mapController.setCenter(LatLng(latlng[0][0], latlng[0][1]));
                  mapController.setLevel(7);
                },
                color: buttonType == ButtonType.coffee ? Colors.blue : Colors.grey,
                child: const Text('Day 1'),
              ),
              MaterialButton(
                onPressed: () {
                  buttonType = ButtonType.store;
                  setState(() {});
                  mapController.setCenter(LatLng(latlng[1][0], latlng[1][1]));
                  mapController.setLevel(7);
                },
                color: buttonType == ButtonType.store? Colors.blue : Colors.grey,
                child: const Text('Day 2'),
              ),
              MaterialButton(
                onPressed: () {
                  buttonType = ButtonType.carpark;
                  setState(() {});
                  mapController.setCenter(LatLng(latlng[2][0], latlng[2][1]));
                  mapController.setLevel(7);
                },
                color: buttonType == ButtonType.carpark? Colors.blue : Colors.grey,
                child: const Text('Day 3'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
