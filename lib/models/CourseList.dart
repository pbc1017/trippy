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

  void removeCourse(int dayIndex, int index) {
    _courses[dayIndex].removeAt(index);
    notifyListeners();
  }

  void reorderCourses(int dayIndex, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Course course = _courses[dayIndex].removeAt(oldIndex);
    _courses[dayIndex].insert(newIndex, course);
    notifyListeners();
  }

  void clear() {
    _courses = [];
    notifyListeners();
  }
}