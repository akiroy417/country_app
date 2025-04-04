import 'package:get/get.dart';
import '../../../core/dependencies.dart';
import '../../../data/models/country_model.dart';
import '../../../data/repositories/country_repository.dart';

class CountryController extends GetxController {
  final CountryRepository _repository = CountryRepository();
  final RxList<CountryModel> countries = <CountryModel>[].obs;
  final RxList<CountryModel> filteredCountries = <CountryModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString sortOrder = 'asc'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchCountries();
    ever(searchQuery, (_) => filterCountries());
    ever(sortOrder, (_) => sortCountries());
    super.onInit();
  }

  Future<void> fetchCountries() async {
    isLoading.value = true;
    try {
      print("Fetching countries...");
      countries.value = await _repository.fetchCountries();
      print("Fetched countries: ${countries.length}");
      filterCountries();
    } catch (e) {
      print("Error fetching countries: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch countries. Check your internet connection.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterCountries() {
    if (searchQuery.value.isEmpty) {
      filteredCountries.value = List.from(countries);
    } else {
      filteredCountries.value = countries
          .where((country) =>
          country.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
    sortCountries();
  }

  void sortCountries() {
    filteredCountries.sort((a, b) {
      return sortOrder.value == 'asc'
          ? a.population.compareTo(b.population)
          : b.population.compareTo(a.population);
    });
  }

  void toggleSortOrder() {
    sortOrder.value = sortOrder.value == 'asc' ? 'desc' : 'asc';
  }
}
