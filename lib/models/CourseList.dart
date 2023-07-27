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

  void replaceCourse(int dayIndex, int index, Course course) {
    _courses[dayIndex][index] = course;
    print(_courses[dayIndex][index].name);
    notifyListeners();
  }

  void removeCourse(int dayIndex, int index) {
    print("removeCourse called with dayIndex=$dayIndex and index=$index");
    print("Before course removed, courses are ${_courses[dayIndex].length}");
    _courses[dayIndex].removeAt(index);
    print("Course removed, now courses are ${_courses[dayIndex].length}");
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