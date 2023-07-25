import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trippy/FirstSlidePage.dart';
import 'package:trippy/MainFirstPageWidget.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainFirstPageWidget(),
          SlidingUpPanel(
            panel: FirstSlidePage(),
            borderRadius: BorderRadius.circular(20),
            
            )
          ],
        )
    );
  }
}
