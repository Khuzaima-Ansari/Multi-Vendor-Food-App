import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/verification_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(verificationController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        title: ReusableText(
          text: "Please Verify Your Account",
          style: appStyle(12, kGray, FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomContainer(
          color: Colors.white,
          containerContent: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: hieght,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Lottie.asset("assets/anime/delivery.json"),
                  SizedBox(height: 10.h),
                  ReusableText(
                    text: "Verify Your Account",
                    style: appStyle(20, kPrimary, FontWeight.w600),
                  ),
                  SizedBox(height: 20.h),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: kPrimary,
                    borderWidth: 2.0,
                    textStyle: appStyle(17, kDark, FontWeight.w600),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.setCode = verificationCode;
                    }, // end onSubmit
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Enter the 6 digit code sent to your email, If you did not see the email, check your spam folder",
                    textAlign: TextAlign.justify,
                    style: appStyle(10, kGray, FontWeight.normal),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "V E R I F Y A C C O U N T",
                    onTap: () {
                      controller.verificationFunction();
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
