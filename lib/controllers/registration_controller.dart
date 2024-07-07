import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/success_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final box = GetStorage();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set setLoading(bool val) => _isLoading.value = val;

  void registerFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse('$appBaseUrl/register');

    try {
      var response = await http.post(url, body: data, headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);
      if (response.statusCode == 201) {
        var data = successModelFromJson(response.body);
        setLoading = false;

        Get.back();

        Get.snackbar(
          "Registration Successful",
          data.message,
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to login",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
        );
      }
    } catch (e) {}
  }
}
