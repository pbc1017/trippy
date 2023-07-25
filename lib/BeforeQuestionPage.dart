import 'package:flutter/material.dart';
import 'package:trippy/QuestionPage.dart';
import 'package:trippy/models/question.dart';
class BeforeQuestionPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/abiansemal.webp',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black54,
          ),
          Center(
            child: Text(
              "당신의 여행 타입은 어떤 타입인가요?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Dmsans',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
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
                    MaterialPageRoute(builder: (context) => QuestionPage(currentQuestionId: 0,)),
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
