import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/controllers/category_controller.dart';
import 'package:foodly/models/foods_model.dart';
import 'package:foodly/models/hook_models/foods_hook.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';

FetchFoods useFetchFoodsByCategory(
  String code,
) {
  final controller = Get.put(CategoryController());
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<APIError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('$appBaseUrl/api/foods/${controller.categoryValue}/$code');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        foods.value = foodsModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      // Catching all errors and exceptions
      if (e is Exception) {
        // It's an exception
        error.value = e;
      } else if (e is Error) {
        // It's an error
        error.value = Exception(e.toString());
      } else {
        // Unknown type
        error.value = Exception('Unknown error occurred');
      }
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchFoods(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
