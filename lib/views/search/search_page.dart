import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly/common/custom_container.dart';
import 'package:foodly/common/custom_text_field.dart';
import 'package:foodly/constants/constants.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        toolbarHeight: 74.h,
        automaticallyImplyLeading: false,
        backgroundColor: kOffWhite,
        title: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: CustomTextField(
              keyboardType: TextInputType.text,
              controller: controller,
              obscureText: false,
              hinText: 'Search for food',
              validator: null,
              suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Ionicons.search_circle,
                    size: 40.h,
                    color: kGray,
                  ))),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Container(),
        ),
      ),
    );
  }
}
