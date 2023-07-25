

class Question {
  final int id;
  final String imageUrl;
  final String questionText;
  double rating; // Change this from int to double

  Question({required this.id, required this.imageUrl, required this.questionText, this.rating = 0.0});

}

final List<Question> questions = [ 
  Question(
    id : 0,
    imageUrl: 'assets/images/signup_1_클럽디오아시스.jpeg',
    questionText: '당신은 클럽디 오아시스로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 1,
    imageUrl: 'assets/images/signup_2_감천문화마을.jpeg',
    questionText: '당신은 부산 감천문화마을로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 2,
    imageUrl: 'assets/images/signup_3_유엔평화기념관.jpeg',
    questionText: '당신은 유엔평화기념관으로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 3,
    imageUrl: 'assets/images/signup_4_요트탈래.jpeg',
    questionText: '당신은 요트탈래로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 4,
    imageUrl: 'assets/images/signup_5_해운대 블루라인파크.jpeg',
    questionText: '당신은 해운대 블루라인파크로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 5,
    imageUrl: 'assets/images/signup_6_해운대 동백섬.jpeg',
    questionText: '당신은 해운대 동백섬으로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 6,
    imageUrl: 'assets/images/signup_7_낙동강 생태탐방선.jpeg',
    questionText: '당신은 낙동강 생태탐방선으로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 7,
    imageUrl: 'assets/images/signup_8_가덕도대항인공동굴.jpeg',
    questionText: '당신은 가덕도대항 인공동굴로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  ),
  Question(
    id : 8,
    imageUrl: 'assets/images/signup_9_해운대수목원.jpeg',
    questionText: '당신은 해운대 수목원으로\n여행을 떠나고 싶으신가요?',
    rating: 0.0,
  )
];
