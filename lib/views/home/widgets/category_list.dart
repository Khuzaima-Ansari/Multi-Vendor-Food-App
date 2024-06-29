import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly/common/shimmers/categories_shimmer.dart';
import 'package:foodly/hooks/fetch_categories.dart';
import 'package:foodly/models/categories.dart';

import 'category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoriesModel>? categorieslist = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return Container(
      height: 75.h,
      padding: EdgeInsets.only(left: 12.w, right: 10.w),
      child: isLoading
          ? const CatergoriesShimmer()
          : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(categorieslist!.length, (i) {
                CategoriesModel category = categorieslist[i];
                return CategoryWidget(category: category);
              }),
            ),
    );
  }
}
