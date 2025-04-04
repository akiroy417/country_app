import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/constants.dart';

class ApiProvider {
  final http.Client client = http.Client();

  Future<List<dynamic>> getAllCountries() async {
    try {
      final response = await client.get(Uri.parse(AppConstants.countriesApiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the API: $e');
      throw Exception('Failed to connect to the API: $e');
    }
  }
}