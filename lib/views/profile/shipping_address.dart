import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/user_location_controller.dart';
import 'package:foodly/models/address_model.dart';
import 'package:foodly/views/auth/widgets/email_text_field.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _instruction = TextEditingController();
  LatLng? _selectedPosition;
  List<dynamic> _placeList = [];
  final List<dynamic> _selectedPlace = [];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void moveToSelectedPosition() {
    if (_selectedPosition != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _selectedPosition!,
          zoom: 15,
        ),
      ));
    }
  }

  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$GOOGLE_API_KEY');
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      }
    } else {
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final location = json.decode(response.body);
      final lat = location['result']['geometry']['location']['lat'] as double;
      final lng = location['result']['geometry']['location']['lng'] as double;

      final address = location['result']['formatted_address'] as String;

      String postalCode = '';

      final addressComponents = location['result']['address_components'];

      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
          break;
        }
      }

      setState(() {
        _selectedPosition = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        moveToSelectedPosition();
        _placeList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserLocationController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: const Text('Shipping Address'),
          leading: Obx(
            () => Padding(
              padding: EdgeInsets.only(right: 0.w),
              child: userController.tabIndex == 0
                  ? IconButton(
                      icon: const Icon(
                        AntDesign.closecircleo,
                        color: kRed,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        AntDesign.leftcircleo,
                        color: kDark,
                      ),
                      onPressed: () {
                        userController.setTabIndex = 0;
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
            ),
          ),
          actions: [
            Obx(
              () => userController.tabIndex == 1
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: 8.0.h),
                      child: IconButton(
                        onPressed: () {
                          userController.setTabIndex = 1;
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(
                          AntDesign.rightcircleo,
                          color: kDark,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        body: SizedBox(
          height: hieght,
          width: width,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            onPageChanged: (value) {
              setState(() {
                _pageController.jumpToPage(value);
              });
            },
            children: [
              Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: _selectedPosition ??
                          const LatLng(37.4220936, -122.083922),
                      zoom: 15,
                    ),
                    markers: _selectedPosition == null
                        ? {
                            Marker(
                                markerId: const MarkerId('Your Location'),
                                position: const LatLng(37.4220936, -122.083922),
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  userController.getUserAddress(position);
                                  setState(() {
                                    _selectedPosition = position;
                                  });
                                })
                          }
                        : {
                            Marker(
                                markerId: const MarkerId('Your Location'),
                                position: _selectedPosition!,
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  userController.getUserAddress(position);
                                  setState(() {
                                    _selectedPosition = position;
                                  });
                                })
                          },
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        color: kOffWhite,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                            hintText: 'Search for your address...',
                          ),
                        ),
                      ),
                      _placeList.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: ListView(
                              children:
                                  List.generate(_placeList.length, (index) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      _placeList[index]['description'],
                                    ),
                                    onTap: () {
                                      _getPlaceDetails(
                                          _placeList[index]['place_id']);
                                      _selectedPlace.add(_placeList[index]);
                                    },
                                  ),
                                );
                              }),
                            ))
                    ],
                  )
                ],
              ),
              BackGroundContainer(
                  color: kOffWhite,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    children: [
                      SizedBox(height: 30.h),
                      EmailTextField(
                        controller: _searchController,
                        hintText: 'Address',
                        prefixIcon: const Icon(Ionicons.location_sharp),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15.h),
                      EmailTextField(
                        controller: _postalCode,
                        hintText: 'Postal Code',
                        prefixIcon: const Icon(Ionicons.location_sharp),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15.h),
                      EmailTextField(
                        controller: _instruction,
                        hintText: 'Celivery Instructions',
                        prefixIcon: const Icon(Ionicons.location_sharp),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                              text: "Set address as default",
                              style: appStyle(12, kDark, FontWeight.w600),
                            ),
                            Obx(
                              () => CupertinoSwitch(
                                thumbColor: kSecondary,
                                trackColor: kPrimary,
                                value: userController.isDefault,
                                onChanged: (value) {
                                  userController.setIsDefault = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      CustomButton(
                        text: "S U B M I T",
                        btnHeight: 45.h,
                        onTap: () {
                          if (_searchController.text.isNotEmpty &&
                              _postalCode.text.isNotEmpty &&
                              _instruction.text.isNotEmpty) {
                            AddressModel model = AddressModel(
                              addressLine1: _searchController.text,
                              postalCode: _postalCode.text,
                              addressModelDefault: userController.isDefault,
                              deliveryInstructions: _instruction.text,
                              latitude: _selectedPosition!.latitude,
                              longitude: _selectedPosition!.longitude,
                            );

                            String data = addressModelToJson(model);
                          }
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
