import 'package:flutter/material.dart';
import 'package:trippy/main.dart';
import 'package:trippy/HomePage.dart';


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
                    MaterialPageRoute(builder: (context) => HomePage()),
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