class Course {
  final String imageUrl;
  final String name;
  final String place;
  final double rating;
  final int price;
  final String duration;

  Course({
    required this.imageUrl,
    required this.name,
    required this.place,
    required this.rating,
    required this.price,
    required this.duration,
  });
}

final List<Course> courses= [
  Course(
      imageUrl: 'assets/images/abiansemal.webp',
      name: 'Abiansemal, Indodesia',
      place: 'Busan',
      rating: 4.87,
      price: 365,
      duration: 'Jul 2-7'),
  Course(
      imageUrl: 'assets/images/Santorini.webp',
      name: 'Santorini, Greece',
      place: 'Busan',
      rating: 4.49,
      price: 285,
      duration: 'April 20-25'),
  Course(
      imageUrl: 'assets/images/LakeArrowhead.webp',
      name: 'Lake Arrowhead, California',
      place: 'Busan',
      rating: 4.57,
      price: 245,
      duration: 'Sept 2-7'),
  Course(
      imageUrl: 'assets/images/spain.webp',
      name: 'Tias, Spain',
      place: 'Busan',
      rating: 4.03,
      price: 199,
      duration: 'Dec 12-16'),
  Course(
      imageUrl: 'assets/images/Santorini.webp',
      name: 'Santorini, Greece',
      place: 'Busan',
      rating: 4.49,
      price: 285,
      duration: 'April 20-25'),
  Course(
      imageUrl: 'assets/images/dubai.webp',
      name: 'Dubai, UAE',
      place: 'Busan',
      rating: 4.90,
      price: 95,
      duration: 'Nov 1-6'),
];
