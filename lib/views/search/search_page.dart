import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/custom_text_field.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/search_controller.dart';
import 'package:foodly/views/search/loading_widget.dart';
import 'package:foodly/views/search/search_result.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodsController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        toolbarHeight: 74.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: CustomTextField(
              keyboardType: TextInputType.text,
              controller: _searchController,
              obscureText: false,
              hinText: 'Search for food',
              validator: null,
              suffixIcon: GestureDetector(
                  onTap: () {
                    if (controller.isTriggered == false) {
                      controller.searchFoods(_searchController.text);
                      controller.setTrigger = true;
                    } else {
                      controller.searchResults = null;
                      controller.setTrigger = false;
                      _searchController.clear();
                    }
                  },
                  child: controller.isTriggered == false
                      ? Icon(
                          Ionicons.search_circle,
                          size: 40.h,
                          color: kGray,
                        )
                      : Icon(
                          Ionicons.close_circle,
                          size: 40.h,
                          color: kRed,
                        ))),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: Colors.white,
          containerContent: controller.isLoading
              ? const FoodsListShimmer()
              : controller.searchResults == null
                  ? const LoadingWidget()
                  : SearchResults(),
        ),
      ),
    );
  }
}
