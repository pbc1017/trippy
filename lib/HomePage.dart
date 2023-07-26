import 'package:flutter/material.dart';
import 'package:trippy/SecondPage.dart';
import 'FirstPage.dart';
import 'ThirdPage.dart';
import 'FourthPage.dart';
import 'FifthPage.dart';
class BottomNavi extends StatefulWidget {
  @override
  _BottomNaviState createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff2F8D46),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
    FifthPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 90.0,  // 원하는 높이를 여기에 입력하세요.
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 41, 216, 128),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, size: 30.0, color: Colors.white,), 
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.search, size: 30.0, color: Colors.white,),
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 30.0, color: Colors.white,),
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.message, size: 30.0, color: Colors.white,),
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, size: 30.0, color: Colors.white,),
              onPressed: () {
                setState(() {
                  pageIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

