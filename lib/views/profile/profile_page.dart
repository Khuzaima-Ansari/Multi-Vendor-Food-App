import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/custom_button.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/profile_app_bar.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/login_controller.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/views/auth/login_page.dart';
import 'package:foodly/views/auth/login_redirect.dart';
import 'package:foodly/views/auth/verification_page.dart';
import 'package:foodly/views/profile/widgets/profile_tile_widget.dart';
import 'package:foodly/views/profile/widgets/user_info_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller = Get.put(LoginController());
    final box = GetStorage();
    String? token = box.read("token");
    if (token != null) {
      user = controller.getUserInfo();
    }
    if (token == null) {
      return const LoginRedirect();
    }
    if (user != null && user.verification == false) {
      return const VerificationPage();
    }
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const ProfileAppBar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              UserInfoWidget(user: user),
              SizedBox(width: 10.h),
              Container(
                height: 190.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      title: "My Orders",
                      icon: Ionicons.fast_food_outline,
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                    ),
                    ProfileTileWidget(
                      title: "My favourite Places",
                      icon: Ionicons.heart_outline,
                      onTap: () {},
                    ),
                    ProfileTileWidget(
                      title: "Review",
                      icon: Ionicons.chatbubble_outline,
                      onTap: () {},
                    ),
                    ProfileTileWidget(
                      title: "Coupons",
                      icon: MaterialCommunityIcons.tag_outline,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 190.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      title: "Shipping Address",
                      icon: SimpleLineIcons.location_pin,
                      onTap: () {},
                    ),
                    ProfileTileWidget(
                      title: "Service Center",
                      icon: AntDesign.customerservice,
                      onTap: () {},
                    ),
                    ProfileTileWidget(
                      title: "Coupons",
                      icon: MaterialIcons.rss_feed,
                      onTap: () {},
                    ),
                    ProfileTileWidget(
                      title: "Settings",
                      icon: AntDesign.setting,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Logout",
                btnColor: kRed,
                btnRadius: 0,
                onTap: () {
                  controller.logoutFunction();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
