import 'package:flutter/material.dart';

class Item {
  final String imageUrl;
  final String title;
  final String place;

  Item({required this.imageUrl, required this.title, required this.place});
}

class FirstSlidePage extends StatelessWidget{
  List<Item> items = [
    Item(imageUrl: 'assets/images/sunrise.jpg', title: 'Sunrise', place: '부산'),
    Item(imageUrl: 'assets/images/mountain.jpg', title: 'Mountain', place: '부산'),
    Item(imageUrl: 'assets/images/activity.jpg', title: 'Activity', place: '부산'),
    Item(imageUrl: 'assets/images/ocean.jpg', title: 'Ocean', place: '부산'),
    Item(imageUrl: 'assets/images/sunrise.jpg', title: '노을 어때요?', place: '부산')
  ];
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10),
          child : Container (
            width: 100,
            child: Image.asset('assets/images/line.png'))),
          Align(
            alignment : Alignment.topLeft,
            child : Padding(
              padding : EdgeInsets.only(top:10, left: 20),
              child:
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontFamily: "Dmsans",
                    fontWeight: FontWeight.w700,
                    fontSize: 24
                  ),
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child:
            Container(
              height: 200.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200.0,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              items[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: 
                              Padding(padding: EdgeInsets.only(bottom :10)
                              , child: Container(
                              width: 160,
                              height: 80,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.6000000238418579),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, top: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left:8), 
                                      child:
                                        Text(
                                          '${items[index].title}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(padding: EdgeInsets.only(left: 4),child:
                                    Row(
                                      
                                      mainAxisAlignment: MainAxisAlignment.start, // Align Row items to start
                                      crossAxisAlignment: CrossAxisAlignment.center, // C
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/place.png', // replace with your image path
                                          width: 15, // adjust as needed
                                          height: 15, // adjust as needed
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "Busan",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: "Dmsans",
                                            fontWeight: FontWeight.w500
                                          ),
                                          ),
                                        SizedBox(width: 25), // Add space between images
                                        Image.asset(
                                          'assets/images/date.png', // replace with your image path
                                          width: 15, // adjust as needed
                                          height: 15, // adjust as needed
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "July 18",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: "Dmsans",
                                            fontWeight: FontWeight.w500
                                          ),
                                          ),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 200.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: 100.0,
                  child: Card(
                    child: Text('Vertical Item $index'),
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
