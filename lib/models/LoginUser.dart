import 'package:flutter/foundation.dart';
import 'tripCourse.dart';

class LoginUser with ChangeNotifier {
  String _user = "";
  String get user => _user;

  
  void setUser(String user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    _user = "";
    notifyListeners();
  }
}