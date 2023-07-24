import 'package:flutter/material.dart';
import 'package:trippy/SignUpPage.dart';
void main() {
  runApp(MainApp());
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
