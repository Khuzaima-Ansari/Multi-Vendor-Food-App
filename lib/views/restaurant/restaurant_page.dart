import 'package:flutter/material.dart';
import 'package:foodly/models/restaurants_model.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key, required this.restaurant});
  final RestaurantsModel? restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Page'),
      ),
      body: const Center(
        child: Text('Restaurant Page'),
      ),
    );
  }
}
