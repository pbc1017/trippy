import 'package:flutter/material.dart';
import 'package:trippy/models/tripCourse.dart';
import 'package:trippy/CourseWidget.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  final int index;
  const CourseWidget({Key? key, required this.course, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: <Widget>[
          Container(
            height: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(course.imageUrl), fit: BoxFit.cover),
            ),
          ),
          const Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          )
        ]),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              course.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(course.rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            )
          ],
        ),
        Text(
          '${course.place} kilometers',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        Text(course.duration,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
        Row(
          children: [
            Text('\$${course.price}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const Text(' night',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ))
          ],
        )
      ],
    );
  }
}
