import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:foodly/models/order_model.dart';
import 'package:foodly/models/restaurants_model.dart';
import 'package:foodly/views/orders/widgets/order_tile.dart';
import 'package:foodly/views/restaurant/widgets/row_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.restaurant,
    required this.food,
    required this.item,
  });

  @override
  _OrderPageState createState() => _OrderPageState();
  final RestaurantsModel? restaurant;
  final FoodsModel? food;
  final OrderItem item;
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: ReusableText(
          text: "Complete Ordering",
          style: appStyle(
            13,
            kLightWhite,
            FontWeight.w600,
          ),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              OrderTile(
                food: widget.food!,
              ),
              Container(
                width: width,
                height: hieght / 3.9,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: widget.restaurant!.title,
                          style: appStyle(
                            20,
                            kGray,
                            FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kPrimary,
                          backgroundImage: NetworkImage(
                            widget.restaurant!.logoUrl,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
                    RowText(
                      first: "Business Hours",
                      second: widget.restaurant!.time,
                    ),
                    SizedBox(height: 5.h),
                    const RowText(
                      first: "Distance from Restaurant",
                      second: "3 km",
                    ),
                    SizedBox(height: 5.h),
                    const RowText(
                      first: "Price from Restaurant",
                      second: "\$ ${4.00}",
                    ),
                    SizedBox(height: 5.h),
                    RowText(
                      first: "Order Total",
                      second: "\$ ${widget.item.price.toString()}",
                    ),
                    SizedBox(height: 10.h),
                    ReusableText(
                      text: "Addtitves",
                      style: appStyle(
                        20,
                        kGray,
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: width,
                      height: 15.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.item.additives.length,
                          itemBuilder: (context, i) {
                            String additive = widget.item.additives[i];
                            return Container(
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                color: kSecondaryLight,
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: ReusableText(
                                    text: additive,
                                    style: appStyle(8, kGray, FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              CustomButton(
                text: "Proceed to Payment",
                btnHeight: 45,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
