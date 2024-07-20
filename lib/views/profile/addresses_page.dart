import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/hooks/fetch_addresses.dart';
import 'package:foodly/models/addresses_response.dart';
import 'package:foodly/views/profile/shipping_address.dart';
import 'package:foodly/views/profile/widgets/address_list.dart';
import 'package:get/get.dart';

class Addresses extends HookWidget {
  const Addresses({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAddresses();
    final List<AddressResponse> addresses = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: BackGroundContainer(
        color: kOffWhite,
        child: Stack(
          children: [
            isLoading
                ? const FoodsListShimmer()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: AddressListWidget(addresses: addresses),
                  ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 30.h),
                child: CustomButton(
                  text: "Add Address",
                  onTap: () {
                    Get.to(() => const ShippingAddress());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
