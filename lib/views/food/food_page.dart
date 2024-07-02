import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_text_field.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/foods_controller.dart';
import 'package:foodly/hooks/fetch_restaurant.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodly/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulHookWidget {
  const FoodPage({super.key, required this.food});
  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final PageController _pageController = PageController();
  final TextEditingController _preference = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurant(widget.food.restaurent);
    final controller = Get.put(FoodsController());
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.r),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 230.h,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) => controller.currentIndex = value,
                      itemCount: widget.food.imageUrl.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width,
                          height: 230.h,
                          color: kLightWhite,
                          child: CachedNetworkImage(
                            imageUrl: widget.food.imageUrl[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(widget.food.imageUrl.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentIndex == index
                                  ? kSecondary
                                  : kGrayLight,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Ionicons.chevron_back,
                      color: kPrimary,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 12.w,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CustomButton(
                        onTap: () {
                          Get.to(() => RestaurantPage(
                                restaurant: hookResult.data,
                              ));
                        },
                        btnWidth: 120.w,
                        text: "Open Restaurant",
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: widget.food.title,
                      style: appStyle(
                        18,
                        kDark,
                        FontWeight.w600,
                      ),
                    ),
                    Obx(
                      () => ReusableText(
                        text:
                            "\$ ${widget.food.price * controller.count.value}",
                        style: appStyle(
                          18,
                          kPrimary,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  widget.food.description,
                  textAlign: TextAlign.justify,
                  maxLines: 8,
                  style: appStyle(11, kGray, FontWeight.w400),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 18.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List.generate(widget.food.foodTags.length, (index) {
                      final tag = widget.food.foodTags[index];
                      return Container(
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: ReusableText(
                            text: tag,
                            style: appStyle(11, kWhite, FontWeight.w400),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 15.h),
                ReusableText(
                  text: "Additives and Toppings",
                  style: appStyle(18, kDark, FontWeight.w600),
                ),
                SizedBox(height: 10.h),
                Column(
                  children:
                      List.generate(widget.food.additives.length, (index) {
                    final additive = widget.food.additives[index];
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      activeColor: kSecondary,
                      tristate: false,
                      value: false,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: additive.title,
                            style: appStyle(11, kDark, FontWeight.w400),
                          ),
                          SizedBox(width: 5.w),
                          ReusableText(
                            text: "\$ ${additive.price}",
                            style: appStyle(11, kPrimary, FontWeight.w600),
                          ),
                        ],
                      ),
                      onChanged: (bool? value) {},
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Quantitiy",
                      style: appStyle(18, kDark, FontWeight.w600),
                    ),
                    SizedBox(width: 5.w),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.increment();
                          },
                          child: const Icon(AntDesign.pluscircleo),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Obx(
                            () => ReusableText(
                              text: controller.count.toString(),
                              style: appStyle(11, kDark, FontWeight.w400),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.decrement();
                          },
                          child: const Icon(AntDesign.minuscircleo),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                ReusableText(
                  text: "Preferences",
                  style: appStyle(18, kDark, FontWeight.w600),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 65.h,
                  child: CustomTextField(
                    controller: _preference,
                    hinText: "Add a note with your preference",
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showVerificationSheet(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ReusableText(
                            text: "Place Order",
                            style: appStyle(18, kLightWhite, FontWeight.w600),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: kSecondary,
                          radius: 20.r,
                          child: const Icon(
                            Ionicons.cart,
                            color: kLightWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 525.h,
          );
        });
  }
}
