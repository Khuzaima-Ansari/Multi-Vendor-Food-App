import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly/models/addresses_response.dart';
import 'package:foodly/models/hook_models/hook_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:foodly/constants/constants.dart';
import 'package:foodly/models/api_error.dart';

FetchHook useFetchDefault() {
  final addresses = useState<AddressResponse?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<APIError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    final box = GetStorage();
    String accessToken = box.read("token") ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      Uri url = Uri.parse('$appBaseUrl/api/address/default');
      final response = await http.get(url, headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        addresses.value = AddressResponse.fromJson(data);
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
    data: addresses.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
