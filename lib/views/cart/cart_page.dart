import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/common/app_style.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/reusable_text.dart';
import 'package:foodly/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly/constants/constants.dart';
import 'package:foodly/controllers/login_controller.dart';
import 'package:foodly/hooks/fetch_cart.dart';
import 'package:foodly/models/cart_response.dart';
import 'package:foodly/models/login_response.dart';
import 'package:foodly/views/auth/login_redirect.dart';
import 'package:foodly/views/auth/verification_page.dart';
import 'package:foodly/views/cart/widgets/cart_tile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCart();
    final List<CartResponse> carts = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: "Cart",
          style: appStyle(14, kGray, FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: isLoading
              ? const FoodsListShimmer()
              : SizedBox(
                  width: width,
                  height: hieght,
                  child: ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      var cart = carts[index];
                      return CartTile(
                        cart: cart,
                        refetch: refetch,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
