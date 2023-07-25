import 'package:flutter/material.dart';

class MainFirstPageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          //배경 사진
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/head.png'),
                fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
              ),
            ),
            ),
          ),
          // 왼쪽 list button
          Padding(
            padding:EdgeInsets.only(left:30, top:65),
            child:
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/listbutton.png'),  // Path to your image
                    fit: BoxFit.fill,
                  ),
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
              )
          ),
          //오른쪽 프로필 버튼
          Align(
            alignment: Alignment.topRight,
            child :
              Padding(
              padding:EdgeInsets.only(right:30, top:65),
              child:
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFEFFFF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Image.asset('assets/images/exampleprofile.png', width: 35, height: 35, fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0), // Adjust the padding value to your needs
                        child: Text('Atia', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "Dmsans",fontWeight:FontWeight.w500)),
                      )

                    ],
                  ),
                ),
            )
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 150, left: 45),
            child: 
              Text("Hello Atia,", style: TextStyle(fontSize: 24,fontFamily: "Dmsans", fontWeight: FontWeight.w700),)
          ),
          Align(
            alignment : Alignment.topCenter,
            child:  
                Padding(
                padding: EdgeInsets.only(top: 200),
                child: 
                  Text("Welcome to TRIPPY", style: TextStyle(fontSize: 32,fontFamily: "Dmsans", fontWeight: FontWeight.w700),)
              ),
          )
        ],
      );
   
  }
}
