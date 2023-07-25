import 'package:flutter/material.dart';


class FirstSlidePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text('Some Text Here'), // Text widget
          Container(
            height: 200.0,
            child: ListView.builder( // Horizontal ListView
              shrinkWrap: true,
              
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 200.0,
                  child: Card(
                    child: Text('Horizontal Item $index'),
                  )
                );
              },
            ),
          ),
          Container(
            height: 200.0,
            child: ListView.builder( // Vertical ListView
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
