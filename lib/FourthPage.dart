import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trippy/FirstSlidePage.dart';
import 'package:trippy/MainFirstPageWidget.dart';
import 'MainFourthPageWidget.dart';
import 'FourthSlidePage.dart';
class FourthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainFourthPageWidget(),
          SlidingUpPanel(
            
            panel: FourthSlidePage(),
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
            
            )
          ],
        )
    );
  }
}




