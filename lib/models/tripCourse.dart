import 'dart:convert';

Course courseFromJson(String str) {
  final jsonData = json.decode(str);
  return Course.fromJson(jsonData);
}

String courseToJson(Course data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Course {
  final String id;
  final String name;
  final int cluster;
  final double latitude;
  final double longitude;
  final String img;
  final String call;
  final String oneliner;
  final String detail;
  final String isPark;

  Course({
    required this.id,
    required this.name,
    required this.cluster,
    required this.latitude,
    required this.longitude,
    required this.img,
    this.call = "010-xxxx-xxxx",
    this.oneliner = "아름다운 공간입니다.",
    required this.detail,
    this.isPark = "불가능",
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"]?? '',
        name: json["name"] ?? '',
        cluster: json["cluster"] ?? 0,
        latitude: json["latitude"] ?? 0,
        longitude: json["longitude"] ?? 0,
        img: json["img"]?? 'https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=c1d8a3e5-ed23-452f-9db2-8fb88619ec88',
        call: json["call"] ?? '',
        oneliner: json["oneliner"]?? '',
        detail: json["detail"] ?? '',
        isPark: json["isPark"] ?? '',
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cluster": cluster,
        "latitude": latitude,
        "longitude": longitude,
        "img": img,
        "call": call,
        "oneliner": oneliner,
        "detail": detail,
        "isPark": isPark,
    };
}
