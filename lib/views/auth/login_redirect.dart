import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: ReusableText(
          text: "Please login to access this page",
          style: appStyle(12, kGray, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80.h),
            Lottie.asset("assets/anime/delivery.json"),
            SizedBox(height: 80.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                btnHeight: 40.h,
                text: "Login",
                onTap: () {
                  Get.to(() => const LoginPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
