import 'package:flutter/material.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final box = GetStorage();
  RxBool isLoading = false.obs;
  bool get getIsLoading => isLoading.value;
  set setIsLoading(bool val) => isLoading.value = val;

  void addToCart(String cart) async {
    setIsLoading = true;
    String token = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/cart");

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: cart,
      );
      if (response.statusCode == 201) {
        setIsLoading = false;

        Get.snackbar(
          "Added to cart",
          "Item added to cart",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Icons.check_circle_outline),
        );
      } else {
        var error = apiErrorFromJson(response.body);

        Get.snackbar(
          "Error",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
        );
      }
    } catch (e) {
    } finally {
      setIsLoading = false;
    }
  }

  void removeToCart(String productId, Function refetch) async {
    setIsLoading = true;
    String token = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/cart/$productId");

    try {
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        setIsLoading = false;
        refetch();
        Get.snackbar(
          "Product removed",
          "Product removed from cart",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Icons.check_circle_outline),
        );
      } else {
        var error = apiErrorFromJson(response.body);

        Get.snackbar(
          "Error",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline),
        );
      }
    } catch (e) {
    } finally {
      setIsLoading = false;
    }
  }
}
