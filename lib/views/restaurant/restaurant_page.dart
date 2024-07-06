import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/restaurants_model.dart';
import 'package:foodly/views/restaurant/directions_page.dart';
import 'package:foodly/views/restaurant/widgets/explore_widget.dart';
import 'package:foodly/views/restaurant/widgets/restaurant_menu.dart';
import 'package:get/get.dart';

import 'widgets/restaurant_bottom_bar.dart';
import 'widgets/row_text.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});
  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: kLightWhite,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 230.h,
                    width: width,
                    child: CachedNetworkImage(
                      imageUrl: widget.restaurant!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: RestaurantBottomBar(widget: widget),
                  ),
                  Positioned(
                    top: 40.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Ionicons.chevron_back_circle,
                              size: 28,
                              color: kLightWhite,
                            ),
                          ),
                          ReusableText(
                              text: widget.restaurant!.title,
                              style: appStyle(13, kDark, FontWeight.w600)),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const DirectionsPage(),
                              );
                            },
                            child: const Icon(
                              Ionicons.location,
                              size: 28,
                              color: kLightWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const RowText(
                        first: "Distance to Restaurant", second: "2.7 km"),
                    SizedBox(height: 3.h),
                    const RowText(
                        first: "Estimated Price", second: "\$ ${2.7}"),
                    SizedBox(height: 3.h),
                    const RowText(first: "Estimated Time", second: "30 min"),
                    const Divider(thickness: 0.7),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Container(
                  height: 25.h,
                  width: width,
                  decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelColor: kLightWhite,
                    labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                    unselectedLabelColor: kGrayLight,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25.h,
                          child: const Center(
                            child: Text("Menu"),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25.h,
                          child: const Center(
                            child: Text("Explore"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: SizedBox(
                    height: hieght,
                    child: TabBarView(controller: _tabController, children: [
                      RestaurantMenuWidget(restaurantId: widget.restaurant!.id),
                      ExploreWidget(code: widget.restaurant!.code),
                    ]),
                  )),
            ],
          )),
    );
  }
}
