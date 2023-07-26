import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/SpotWidget.dart';

class SpotSearch extends StatefulWidget {
  final List<Course> courses;
  final String type;

  SpotSearch({Key? key, required this.courses, required this.type}) : super(key: key);

  @override
  _SpotSearchState createState() => _SpotSearchState();
}

class _SpotSearchState extends State<SpotSearch> {
  List<Course> spots = [];

  @override
  void initState() {
    super.initState();
    fetchSpots();
  }

  fetchSpots() async {
    var points = widget.courses.map((course) => {
      "id": course.id,
      "latitude": course.latitude,
      "longitude": course.longitude,
    }).toList();

    var body = json.encode({
      "points": points,
      "type": widget.type,
    });

    var response = await http.post(
      Uri.parse("http://localhost:80/api/search?query="),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body) as List;
      spots = result.map((item) => Course.fromJson(item)).toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spot Search"),
      ),
      body: ListView.builder(
        itemCount: spots.length,
        itemBuilder: (context, index) {
          return SpotWidget(course: spots[index]);
        },
      ),
    );
  }
}
