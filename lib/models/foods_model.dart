import 'dart:convert';

class FoodsModel {
  final String id;
  final String title;
  final String time;
  final List<String> foodTags;
  final List<String> foodType;
  final String category;
  final String code;
  final bool isAvailable;
  final String restaurent;
  final double rating;
  final String ratingCount;
  final String description;
  final double price;
  final List<Additive> additives;
  final List<String> imageUrl;

  FoodsModel({
    required this.id,
    required this.title,
    required this.time,
    required this.foodTags,
    required this.foodType,
    required this.category,
    required this.code,
    required this.isAvailable,
    required this.restaurent,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.additives,
    required this.imageUrl,
  });

  factory FoodsModel.fromRawJson(String str) =>
      FoodsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        category: json["category"],
        code: json["code"],
        isAvailable: json["isAvailable"],
        restaurent: json["restaurent"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        additives: List<Additive>.from(
            json["additives"].map((x) => Additive.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "category": category,
        "code": code,
        "isAvailable": isAvailable,
        "restaurent": restaurent,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}

class Additive {
  final int id;
  final String title;
  final String price;

  Additive({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Additive.fromRawJson(String str) =>
      Additive.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"],
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
      };
}
