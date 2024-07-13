import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
}
