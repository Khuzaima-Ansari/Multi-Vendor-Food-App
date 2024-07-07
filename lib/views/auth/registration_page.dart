import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/registration_controller.dart';
import 'package:foodly/models/registration_model.dart';
import 'package:foodly/views/auth/login_page.dart';
import 'package:foodly/views/auth/widgets/email_text_field.dart';
import 'package:foodly/views/auth/widgets/password_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        title: Center(
          child: ReusableText(
            text: "Foodly Family",
            style: appStyle(20, kLightWhite, FontWeight.bold),
          ),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Lottie.asset("assets/anime/delivery.json"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    EmailTextField(
                      controller: _usernameController,
                      hintText: "Username",
                      prefixIcon: const Icon(
                        CupertinoIcons.person,
                        size: 22,
                        color: kGrayLight,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    EmailTextField(
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: const Icon(
                        CupertinoIcons.mail,
                        size: 22,
                        color: kGrayLight,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    PasswordTextField(
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: "R E G I S T E R",
                      onTap: () {
                        if (_emailController.text.isNotEmpty &&
                            _usernameController.text.isNotEmpty &&
                            _passwordController.text.length >= 8) {
                          RegistrationModel model = RegistrationModel(
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text);
                          String data = registrationModelToJson(model);
                          controller.registerFunction(data);
                        }
                      },
                      btnHeight: 35.h,
                      btnWidth: width,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
