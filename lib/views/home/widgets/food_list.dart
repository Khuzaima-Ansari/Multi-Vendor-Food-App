import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/nearby_shimmer.dart';
import 'package:foodly/hooks/fetch_foods.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:foodly/views/food/food_page.dart';
import 'package:foodly/views/home/widgets/food_widget.dart';
import 'package:get/get.dart';

class FoodList extends HookWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFoods("41007428");
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;
    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 184.h,
            padding: EdgeInsets.only(left: 12.w, right: 10.w),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(foods!.length, (i) {
                var food = foods[i];
                return FoodWidget(
                  image: food.imageUrl[0],
                  time: food.time,
                  title: food.time,
                  price: food.price.toStringAsFixed(2),
                  onTap: () {
                    Get.to(() => FoodPage(food: food));
                  },
                );
              }),
            ),
          );
  }
}
