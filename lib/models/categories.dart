import 'dart:convert';

class CategoriesModel {
  final String id;
  final String title;
  final String value;
  final String imageUrl;

  CategoriesModel({
    required this.id,
    required this.title,
    required this.value,
    required this.imageUrl,
  });

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["_id"],
        title: json["title"],
        value: json["value"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "value": value,
        "imageUrl": imageUrl,
      };
}
