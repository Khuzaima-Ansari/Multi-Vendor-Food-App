import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/entrypoint.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController {
  final RxBool _isDefault = false.obs;
  bool get isDefault => _isDefault.value;
  set setIsDefault(bool val) => _isDefault.value = val;

  final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  set setTabIndex(int val) => _tabIndex.value = val;

  LatLng position = const LatLng(0.0, 0.0);

  void setPosition(LatLng pos) {
    position = pos;
    update();
  }

  final RxString _address = "".obs;
  String get address => _address.value;
  set setAddress(String val) => _address.value = val;

  final RxString _postalCode = "".obs;
  String get postalCode => _postalCode.value;
  set setPostalCode(String val) => _postalCode.value = val;

  Future<void> getUserAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;

        final String address =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';

        setAddress = address;
        if (place.postalCode != null) {
          setPostalCode = place.postalCode!;
        }
      }
    } catch (e) {
      print('Failed to get address: $e');
    }
  }

  void addAddress(String data) async {
    final box = GetStorage();
    String accessToken = box.read("token");

    Uri url = Uri.parse('$appBaseUrl/api/address');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Your address has been added",
          "Enjoy your awesome experience",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(
            Ionicons.fast_food_outline,
          ),
        );
        Get.offAll(() => MainScreen());
      } else {
        Get.snackbar(
          "Failed to add address",
          "Please try again",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(
            Ionicons.fast_food_outline,
          ),
        );
      }
    } catch (e) {}
  }
}
