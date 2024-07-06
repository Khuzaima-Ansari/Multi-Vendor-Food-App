import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/restaurant/rating_page.dart';
import 'package:foodly/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.widget,
  });

  final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: width,
      height: 40.h,
      decoration: BoxDecoration(
        color: kPrimary.withOpacity(0.4),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBarIndicator(
            itemSize: 25,
            itemCount: 5,
            rating: widget.restaurant!.rating.toDouble(),
            itemBuilder: (context, i) {
              return const Icon(
                Icons.star,
                color: Colors.yellow,
              );
            },
          ),
          CustomButton(
            btnColor: kSecondary,
            text: "Rate Restaurant",
            btnWidth: width / 3,
            onTap: () {
              Get.to(() => const RatingPage());
            },
          )
        ],
      ),
    );
  }
}
