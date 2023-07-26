import 'package:flutter/foundation.dart';
import 'tripCourse.dart';

class QuestionList with ChangeNotifier {
  List<double> _results = [];
  List<double> get results => _results;

  Map<String, double> calculateWeightedAverages() {
    // Ensure there are at least 9 ratings
    if (results.length < 9) {
      throw Exception('Less than 9 ratings provided');
    }

    return {
      "_M": (results[6] + results[7] + results[8]) / 3,
      "_U": (results[0] + results[1] + results[2]) / 3,
      "_O": (results[3] + results[4] + results[5]) / 3,
      "_A": (results[0] + results[1] + results[3] + results[5] + results[6] + results[8]) / 6,
      "_B": (results[2] + results[4] + results[7]) / 3,
      "_1": (results[2] + results[5] + results[8]) / 3,
      "_2": (results[1] + results[4] + results[7]) / 3,
      "_3": (results[0] + results[3] + results[6]) / 3
    };
  }
  void addResult(double result) {
    _results.add(result);
    notifyListeners();
  }

  void removeCourse(double result, int resultIndex) {
    _results.removeAt(resultIndex);
    notifyListeners();
  }

  void clear() {
    _results = [];
    notifyListeners();
  }
}