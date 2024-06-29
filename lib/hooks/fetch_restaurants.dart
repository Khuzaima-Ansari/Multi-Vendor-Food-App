import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/models/restaurants_model.dart';
import 'package:http/http.dart' as http;

import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';
import 'package:foodly/models/hook_models/hook_result.dart';

FetchHook useFetchRestaurants(String code) {
  final restaurants = useState<List<RestaurantsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<APIError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/$code');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        restaurants.value = restaurantsModelFromJson(response.body);
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
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
