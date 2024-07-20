import 'dart:convert';

List<CartResponse> cartResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return List<CartResponse>.from(
      jsonData["cart"].map((x) => CartResponse.fromJson(x)));
}

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  final String id;
  final ProductId productId;
  final List<String> additives;
  final double totalPrice;
  final int quantity;

  CartResponse({
    required this.id,
    required this.productId,
    required this.additives,
    required this.totalPrice,
    required this.quantity,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
      id: json["_id"],
      productId: ProductId.fromJson(json["productId"]),
      additives: List<String>.from(json["additives"].map((x) => x)),
      totalPrice: json["totalPrice"]?.toDouble(),
      quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId.toJson(),
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "totalPrice": totalPrice,
        "quantity": quantity
      };
}

class ProductId {
  final String id;
  final String title;
  final String restaurent;
  final double rating;
  final String ratingCount;
  final List<String> imageUrl;

  ProductId({
    required this.id,
    required this.title,
    required this.restaurent,
    required this.rating,
    required this.ratingCount,
    required this.imageUrl,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        title: json["title"],
        restaurent: json["restaurent"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "restaurent": restaurent,
        "rating": rating,
        "ratingCount": ratingCount,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
