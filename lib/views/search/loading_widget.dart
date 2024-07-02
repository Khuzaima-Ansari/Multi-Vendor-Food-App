import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/constants/constants.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: hieght,
      child: Padding(
          padding: EdgeInsets.only(bottom: 180.h),
          child: LottieBuilder.asset(
            "assets/anime/delivery.json",
            width: width,
            height: hieght / 2,
          )),
    );
  }
}
