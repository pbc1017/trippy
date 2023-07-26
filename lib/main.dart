import 'package:flutter/material.dart';
import 'package:trippy/SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trippy/models/LoginUser.dart';
import 'HomePage.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:trippy/models/CourseList.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:trippy/models/QuestionList.dart';
import 'package:trippy/models/LoginUser.dart';

class FavoriteCourseIndex with ChangeNotifier {
  int favoriteDayIndex = -1;
  int favoriteIndex = -1;

  setFavoriteIndex(int dayIndex, int index) {
    favoriteDayIndex = dayIndex;
    favoriteIndex = index;
    notifyListeners();
  }

  clearFavoriteIndex() {
    favoriteDayIndex = -1;
    favoriteIndex = -1;
    notifyListeners();
  }
}

void main() {
  AuthRepository.initialize(appKey: '40006b7e99b12e8a4b89ffa4c4e9a361');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CourseList()),
        ChangeNotifierProvider(create: (context) => QuestionList()),
        ChangeNotifierProvider(create: (context) => LoginUser()),
        ChangeNotifierProvider(create: (context) => FavoriteCourseIndex()),  // Add this line
      ],
      child: MainApp(),
    ),
  );
}


void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InputPage(),
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  void _signIn() async {
    final response = await http.post(
      Uri.parse('http://localhost:80/api/signin'), // replace with your server url
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _textController1.text,
        'password': _textController2.text,
      }),
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      
      if(data == "false") {
        print(response.body);
        showToast("아이디가 존재하지 않습니다");
        throw Exception('Login failed. Invalid username or password.');
      } else {
        Provider.of<LoginUser>(context, listen: false).setUser(_textController1.text);
        print(Provider.of<LoginUser>(context, listen: false).user);
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
        //print('User ID: ${data["fullname"]}');  // assuming the user id is returned in the response
        // Insert further actions to be taken upon successful login here.
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create account.');
    }
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 150,),
          const Text("Welcome Back", style: TextStyle(
            fontFamily: 'Dmsans',
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 36,

          )),
          const SizedBox(height: 20,),
          const Text("Hi! Welcome back, you've been missed", style: TextStyle(
              fontFamily: 'Dmsans',
              fontWeight: FontWeight.w300,
              fontSize: 18
          ),),
          const SizedBox(height: 50,),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Email", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                fontSize: 16
            ),),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _textController1,
            decoration: InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: 'Enter your email',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _focusNode1.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text("Password", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                fontSize: 16
            ),),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: _textController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
              labelText: 'Enter your password',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _focusNode2.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,
              
            ),
            ),
          ),
          SizedBox(height: 30),
          Container(
          width: double.infinity,
          height: 55.0,  // 높이를 원하는 만큼 설정합니다.
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 41, 216, 128)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            onPressed: () {
              print('Input 1: ${_textController1.text}');
              print('Input 2: ${_textController2.text}');
              _signIn();
            },
            child: Text('Sign In', style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 20
            ),),
          ),
          
        ),
        SizedBox(height: 20),
         Container(width: 500,
           child: Divider(color: Colors.grey, thickness: 1.0)),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: Text("You don't have an account yet? Sign in", style: TextStyle(
            fontFamily: 'Dmsans',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 14,
          )),
        ),

        ],
        
      ),
    );
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }
}
