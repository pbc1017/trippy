import 'package:flutter/material.dart';
import 'package:trippy/main.dart';
import 'package:trippy/HomePage.dart';
import 'package:trippy/QuestionPage.dart';
import 'package:trippy/BeforeQuestionPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/question.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _signUp() async {
  final response = await http.post(
    Uri.parse('http://localhost:80/api/signup'), // replace with your server url
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': _emailController.text,
      'password': _passwordController.text,
      'fullname': _fullnameController.text,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    print('Success: ${response.body}');
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to create account.');
  }
}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100,),
              const Text("Create an Account", style: TextStyle(
                color: Color(0xFF0D0140),
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                fontSize: 36,

              )),
              const SizedBox(height: 10,),
              const Text("Fill your information below or register", style: TextStyle(
                color: Color(0xFF514A6B),
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w300,
                fontSize: 16,

              )),

              const SizedBox(height: 40,),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text("FullName", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w400,
                color: Color(0xFF0D0140),
                fontSize: 16
              ),),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _fullnameController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: 'Fullname',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: _focusNode1.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter your fullname';
                  }
                  else return null;
                },
              ),
              const SizedBox(height: 20,),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text("Email", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                color: Color(0xFF0D0140),
                fontSize: 16
              ),),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _focusNode1.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter your email';
                  }
                  else return null;
                },
              ),

              const SizedBox(height: 20,),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D0140),
                fontSize: 16
              ),),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _focusNode1.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter your password';
                  }
                  else return null;
                },
              ),
              const SizedBox(height: 20,),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text("Confirm Password", style: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D0140),
                fontSize: 16
              ),),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _confirmPasswordController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _focusNode1.hasFocus ? Color.fromARGB(255, 41, 216, 128) : Colors.grey,

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 41, 216, 128), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),),
                validator: (value){
                  if(value!= _passwordController.text){
                    return 'Passwords do not match';
                  }
                  else return null;
                },
              ),
              const SizedBox(height: 20,),
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
                    if (_formKey.currentState!.validate()) {
                          print('Processing Data');
                          _signUp();
                        }
                  },
                  child: Text('Sign Up', style: TextStyle(
                      fontFamily: 'Dmsans',
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),),
                ),
          
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BeforeQuestionPage()),
                  );
                },
                child: Text("You don't have an account yet? Sign up", style: TextStyle(
                  fontFamily: 'Dmsans',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14,
                )),
              ),
          ]),
        ), 
        ),
    );
  }
}

