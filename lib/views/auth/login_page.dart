import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/back_ground_container.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/login_controller.dart';
import 'package:foodly/models/login_model.dart';
import 'package:foodly/views/auth/registration_page.dart';
import 'package:foodly/views/auth/widgets/email_text_field.dart';
import 'package:foodly/views/auth/widgets/password_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
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
    final controller = Get.put(LoginController());
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const RegistrationPage(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 900),
                              );
                            },
                            child: ReusableText(
                              text: "Register",
                              style:
                                  appStyle(12, Colors.blue, FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      text: "L O G I N",
                      onTap: () {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.length >= 8) {
                          LoginModel model = LoginModel(
                              email: _emailController.text,
                              password: _passwordController.text);
                          String data = loginModelToJson(model);
                          controller.loginFunction(data);
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
