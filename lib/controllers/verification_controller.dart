import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/views/entrypoint.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class verificationController extends GetxController {
  final box = GetStorage();
  final RxString _code = "".obs;
  String get code => _code.value;
  set setCode(String val) => _code.value = val;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool val) => _isLoading.value = val;

  void verificationFunction() async {
    setLoading = true;
    String accessToken = box.read("token");

    Uri url = Uri.parse('$appBaseUrl/api/users/verify/$code');

    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      if (response.statusCode == 200) {
        LoginResponse data = loginResponseFromJson(response.body);
        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData);
        box.write("userId", data.id);
        box.write("token", data.userToken);
        box.write("verification", data.verification);

        setLoading = false;

        Get.snackbar(
          "Verification Successful",
          "Enjoy your awesome experience with Foodly",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );

        Get.offAll(() => MainScreen());
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to verify account",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
        );
      }
    } catch (e) {}
  }
}
