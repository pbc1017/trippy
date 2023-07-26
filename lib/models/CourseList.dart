import 'package:flutter/foundation.dart';
import 'tripCourse.dart';

class CourseList with ChangeNotifier {
  List<List<Course>> _courses = [];

  List<List<Course>> get courses => _courses;

  void addCourseList() {
    _courses.add([]);
    notifyListeners();
  }

  void addCourse(int dayIndex, Course course) {
    _courses[dayIndex].add(course);
    notifyListeners();
  }

  void removeCourse(int dayIndex, int courseIndex) {
    _courses[dayIndex].removeAt(courseIndex);
    notifyListeners();
  }

  void clear() {
    _courses = [];
    notifyListeners();
  }
}