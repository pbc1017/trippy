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
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: '당신은 산과 바다\n어느 여행지를 더 선호하시나요',
    rating: 0.0,
  ),
  Question(
    id : 1,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 2,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 3,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 4,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 5,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 6,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 7,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  ),
  Question(
    id : 8,
    imageUrl: 'assets/images/abiansemal.webp',
    questionText: 'Sample Question Text',
    rating: 0.0,
  )
];
