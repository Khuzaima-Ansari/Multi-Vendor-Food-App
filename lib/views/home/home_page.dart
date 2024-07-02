import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/custom_appbar.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/heading.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/category_controller.dart';
import 'package:foodly/views/home/all_fastest_foods.dart';
import 'package:foodly/views/home/all_nearby_restaurants.dart';
import 'package:foodly/views/home/recommendations.dart';
import 'package:foodly/views/home/widgets/category_foods_list.dart';
import 'package:foodly/views/home/widgets/category_list.dart';
import 'package:foodly/views/home/widgets/food_list.dart';
import 'package:foodly/views/home/widgets/nearby_restaurant_list.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: const CustomAppBar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              const CategoryList(),
              Obx(
                () => controller.categoryValue == ''
                    ? Column(
                        children: [
                          Heading(
                            text: "Try Something New",
                            onTap: () {
                              Get.to(
                                () => const Recommendations(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 900),
                              );
                            },
                          ),
                          const FoodList(),
                          Heading(
                            text: "Nearby Restaurants",
                            onTap: () {
                              Get.to(
                                () => const AllNearbyRestaurants(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 900),
                              );
                            },
                          ),
                          const NearbyRestaurants(),
                          Heading(
                            text: "Fastest food closer to you",
                            onTap: () {
                              Get.to(
                                () => const AllFastestFoods(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 900),
                              );
                            },
                          ),
                          const FoodList(),
                        ],
                      )
                    : CustomContainer(
                        containerContent: Column(
                          children: [
                            Heading(
                              more: true,
                              text: "Explore ${controller.titleValue} Category",
                              onTap: () {
                                Get.to(
                                  () => const AllFastestFoods(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(milliseconds: 900),
                                );
                              },
                            ),
                            const CategoryFoodList(),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
