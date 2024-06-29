import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/constants/uidata.dart';
import 'package:foodly/hooks/fetch_all_restaurants.dart';
import 'package:foodly/models/restaurants_model.dart';
import 'package:foodly/views/home/widgets/restaurent_tile.dart';

class AllNearbyRestaurants extends HookWidget {
  const AllNearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllRestaurants("41007428");
    List<RestaurantsModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondary,
        title: ReusableText(
          text: 'Nearby Restaurants',
          style: appStyle(13, kLightWhite, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: isLoading
              ? FoodsListShimmer()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(restaurants!.length, (i) {
                    RestaurantsModel restaurant = restaurants[i];
                    return RestaurentTile(restaurant: restaurant);
                  }),
                ),
        ),
      ),
    );
  }
}
