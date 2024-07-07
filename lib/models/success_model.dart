import 'dart:convert';

SuccessModel successModelFromJson(String str) =>
    SuccessModel.fromJson(json.decode(str));

class SuccessModel {
  final bool status;
  final String message;

  SuccessModel({required this.status, required this.message});

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
