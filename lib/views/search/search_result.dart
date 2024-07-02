import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/search_controller.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:foodly/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  SearchResults({super.key});
  final controller = Get.put(SearchFoodsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
      height: hieght,
      child: ListView.builder(
        itemCount: controller.searchResults!.length,
        itemBuilder: (context, i) {
          FoodsModel food = controller.searchResults![i];
          return FoodTile(food: food);
        },
      ),
    );
  }
}
