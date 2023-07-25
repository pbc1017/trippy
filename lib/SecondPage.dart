import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/CourseWidget.dart';
import 'tab_bar.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search, color: Colors.black);
  Widget _appBarTitle = Text('Search...', style: TextStyle(color: Colors.black));
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              width: 350,
              height: 100,
              alignment: Alignment.center,
              child: Material(
                elevation: 4.0,
                shadowColor: Color.fromARGB(93, 1, 0, 0),
                borderRadius: BorderRadius.circular(40),
                child: const TextField(
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: 'Where to?',
                    hintMaxLines: 1,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "Dmsans",
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: Icon(
                      Icons.tune,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: SizedBox(
              height: 46,
              child: Stack(clipBehavior: Clip.none, children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(Colors.black),
                    ),
                  ),
                  child: Scrollbar( 
                    controller: _scrollController,
                    child: Padding( // Added Padding here
                      padding: const EdgeInsets.only(bottom: 0),
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: const <Widget>[
                          TabItem(
                            text: 'Rooms',
                            imageUrl: 'assets/images/rooms.jpeg',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                            text: 'Pools',
                            imageUrl: 'assets/images/pool.jpeg',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                              text: 'Beachfront',
                              imageUrl: 'assets/images/beachfront.jpeg'),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(text: 'Lakes', imageUrl: 'assets/images/lakes.jpeg'),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                            imageUrl: 'assets/images/views.jpeg',
                            text: 'Amazing views',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(text: 'Islands', imageUrl: 'assets/images/palm-tree.png'),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(text: 'Caves', imageUrl: 'assets/images/cave.png'),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                            text: 'Deserts',
                            imageUrl: 'assets/images/cactus.png',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(text: 'Tropical', imageUrl: 'assets/images/island.png'),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                            text: 'Creative spaces',
                            imageUrl: 'assets/images/art.png',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TabItem(
                            text: 'Mansions',
                            imageUrl: 'assets/images/villa.png',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 30),
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                final course = courses[index];
                return CourseWidget(
                  course: course,
                  index: index,
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
