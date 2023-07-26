import 'package:flutter/material.dart';
import 'package:trippy/HomePage.dart';
import 'package:trippy/QuestionPage.dart';
import 'package:trippy/models/question.dart';
class ResultPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/signup_4_요트탈래.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black54,
          ),
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "UFS-L",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Dmsans',
                  fontWeight: FontWeight.w700,
                  fontSize: 54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 230),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "City Adventurer",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Dmsans',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 650),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "도시(U) - 원거리(F) - 체류(S)",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Dmsans',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // this will space out the children evenly
                        children: [
                            Text(
                                'U',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                            Expanded(
                                child: Slider(
                                    value: 8,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    onChanged: (double value) {},
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.white,
                                ),
                            ),
                            Text(
                                '70%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
          Padding(
            padding: EdgeInsets.only(top:150),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // this will space out the children evenly
                        children: [
                            Text(
                                'F',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                            Expanded(
                                child: Slider(
                                    value: 9,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    onChanged: (double value) {},
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.white,
                                ),
                            ),
                            Text(
                                '80%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
        Padding(
            padding: EdgeInsets.only(top:300),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // this will space out the children evenly
                        children: [
                            Text(
                                'S',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                            Expanded(
                                child: Slider(
                                    value: 6,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    onChanged: (double value) {},
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.white,
                                ),
                            ),
                            Text(
                                '60%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dmsans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding( // added some padding for better looking UI
              padding: EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text("Trippy", style: TextStyle(
                  fontFamily: "Dmsans",
                  fontWeight: FontWeight.w700,
                  fontSize : 16)),
                style: ElevatedButton.styleFrom(
                  
                  elevation: 25,
                  primary: Color.fromARGB(141, 107, 107, 107),
                  minimumSize: Size(300, 50), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // provide the desired value of borderRadius
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
