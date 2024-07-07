import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kOffWhite,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/usa.svg",
                  height: 25.h,
                  width: 25.w,
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 1.w,
                  height: 15.h,
                  color: kGrayLight,
                ),
                SizedBox(width: 5.w),
                ReusableText(
                  text: "USA",
                  style: appStyle(16, kDark, FontWeight.normal),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 4.h,
                    ),
                    child: Icon(
                      SimpleLineIcons.settings,
                      size: 16.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
