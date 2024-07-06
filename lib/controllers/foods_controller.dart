import 'package:foodly/models/additives_obs.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:get/get.dart';

class FoodsController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final intialCheckValue = false;
  var additivesList = <AdditiveObs>[].obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int value) {
    _currentIndex.value = value;
  }

  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  void loadAdditive(List<Additive> additives) {
    additivesList.clear();

    for (var additiveInfo in additives) {
      var additive = AdditiveObs(
        id: additiveInfo.id,
        title: additiveInfo.title,
        price: additiveInfo.price,
        checked: intialCheckValue,
      );
      if (additivesList.length == additives.length) {
      } else {
        additivesList.add(additive);
      }
    }
  }

  final RxDouble _totalPrice = 0.0.obs;
  double get totalPrice => _totalPrice.value;
  set setTotalPrice(double totalPrice) {
    _totalPrice.value = totalPrice;
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var additive in additivesList) {
      if (additive.isChecked.value) {
        totalPrice += double.parse(additive.price);
      }
    }
    setTotalPrice = totalPrice;
    return totalPrice;
  }
}
