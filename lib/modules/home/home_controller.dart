import 'package:get/get.dart';
import '../../data/models/custom_country_model.dart';
import 'controllers/country_controller.dart';
import 'controllers/custom_country_controller.dart';
import '../../data/repositories/country_repository.dart';
import '../../modules/auth/auth_controller.dart';

class HomeController extends GetxController {
  // Controllers
  late final CountryController _countryController;
  late final CustomCountryController _customCountryController;

  // State
  final RxInt currentTabIndex = 0.obs;
  final RxBool isRefreshing = false.obs;

  @override
  void onInit() {
    // Initialize sub-controllers
    _countryController = Get.put(CountryController());
    _customCountryController = Get.put(CustomCountryController());

    // Load initial data
    _loadInitialData();
    super.onInit();
  }

  CountryController get countryController => _countryController;
  CustomCountryController get customCountryController => _customCountryController;

  Future<void> _loadInitialData() async {
    try {
      isRefreshing.value = true;
      await _countryController.fetchCountries();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load initial data');
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> refreshData() async {
    try {
      isRefreshing.value = true;
      if (currentTabIndex.value == 0) {
        await _countryController.fetchCountries();
      }
      // Custom countries are stream-based, no refresh needed
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh data');
    } finally {
      isRefreshing.value = false;
    }
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  void prepareForAddCountry() {
    _customCountryController.clearForm();
  }

  void prepareForEditCountry(CustomCountryModel country) {
    _customCountryController.loadFormData(country); // Changed from initForm to loadFormData
  }

  String get currentUserId {
    final authController = Get.find<AuthController>();
    return authController.firebaseUser.value?.uid ?? ''; // Changed from user to firebaseUser
  }

  @override
  void onClose() {
    Get.delete<CountryController>();
    Get.delete<CustomCountryController>();
    super.onClose();
  }
}