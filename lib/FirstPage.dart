import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trippy/FirstSlidePage.dart';
import 'package:trippy/MainFirstPageWidget.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;  // get the height of the screen

    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainFirstPageWidget(),
          SlidingUpPanel(
            panel: FirstSlidePage(),
            minHeight: screenHeight * 0.1,  // set to 20% of the screen height
            maxHeight: screenHeight * 0.35,  // set to 80% of the 
            borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight: Radius.circular(40)),
            
            )
          ],
        )
    );
  }
}
