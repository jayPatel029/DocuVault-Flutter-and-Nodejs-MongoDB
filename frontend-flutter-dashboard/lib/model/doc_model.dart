// class Docs {
//   String? id;
//   String? name;
//   String? description;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Docs({
//     this.id,
//     this.name,
//     this.description,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Docs.fromJson(Map<String, dynamic> json) {
//     return Docs(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       image: json['image'],
//       createdAt:
//           json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       updatedAt:
//           json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
//     );
//   }
// }



import 'package:flutter/services.dart';

class Docs {
  String? id;
  String? name;
  String? description;
  BinaryCodec? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? regNo;

  Docs({
    this.id,
    required this.name,
    required this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.regNo,
  });

  factory Docs.fromJson(Map<String, dynamic> json) {
    return Docs(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: int.tryParse(json['__v'].toString()) ?? 0,
      regNo: json["regNo"],
    );
  }
}
