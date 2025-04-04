import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';

class CountryRepository {
  final String apiUrl = "https://restcountries.com/v3.1/all"; // ✅ API URL

  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<CountryModel> countries = data.map((country) {
          return CountryModel.fromJson(country);
        }).toList();

        return countries;
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
