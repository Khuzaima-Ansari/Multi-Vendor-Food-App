import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: kSecondary,
                  // backgroundImage: const NetworkImage(""),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Deliver to",
                          style: appStyle(13, kSecondary, FontWeight.w600)),
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          "cm;sm ;lcs;lmcs;mcmcsc scs",
                          overflow: TextOverflow.ellipsis,
                          style: appStyle(13, kDark, FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              getTimeOfDay(),
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return " ☀️ ";
    } else if (hour >= 12 && hour < 16) {
      return " ⛅ ";
    } else {
      return " 🌙 ";
    }
  }
}
