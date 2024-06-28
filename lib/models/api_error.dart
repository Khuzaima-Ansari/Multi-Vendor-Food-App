class APIError {
  final bool status;
  final String message;

  APIError({required this.status, required this.message});

  factory APIError.fromJson(Map<String, dynamic> json) {
    return APIError(
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
