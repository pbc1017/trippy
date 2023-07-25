import 'package:flutter/material.dart';
import 'package:trippy/models/question.dart';
import 'package:trippy/HomePage.dart';
import 'package:collection/collection.dart';

class QuestionPage extends StatefulWidget {
  final int currentQuestionId;

  QuestionPage({Key? key, required this.currentQuestionId}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Question currentQuestion;
  double _sliderValue = 0; // Add this to store slider value

  @override
  void initState() {
    super.initState();
    currentQuestion = questions.firstWhere((question) => question.id == widget.currentQuestionId);
  }

  void _updateSlider(double value) {
  setState(() {
    _sliderValue = value;
    currentQuestion.rating = value; // update rating value of the current question
  });
  }
  void _nextQuestion() {
  int nextQuestionId = currentQuestion.id + 1;

  Question? nextQuestion = questions.firstWhereOrNull(
    (question) => question.id == nextQuestionId
  );

  if (nextQuestion == null) {
    // If there's no next question, navigate to ResultPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    setState(() {
      currentQuestion = nextQuestion;
      _sliderValue = 0; // Reset slider value for the new question
    });
  }
}


  

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
              currentQuestion.questionText,
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
            child: Padding(
              padding: EdgeInsets.only(bottom : 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width, // Set width as per your requirement
                    child: Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      onChanged: _updateSlider,
                      activeColor: Colors.green, // For active side
                      inactiveColor: Colors.green.withAlpha(70), // For inactive side
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text("Next", style: TextStyle(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
