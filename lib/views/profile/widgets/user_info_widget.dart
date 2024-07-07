import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/login_response.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});
  final LoginResponse? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hieght * 0.06,
      width: width,
      color: kLightWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 6.w, 0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: CircleAvatar(
                        backgroundColor: kGrayLight,
                        backgroundImage: NetworkImage(user?.profile ?? ""),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.username ?? "Username",
                          style: appStyle(12, kGray, FontWeight.bold),
                        ),
                        Text(
                          user?.email ?? "Email",
                          style: appStyle(12, kGrayLight, FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(
              AntDesign.edit,
              size: 18.h,
            ),
          )
        ],
      ),
    );
  }
}
