import 'package:get/get.dart';

import '../../../core/dependencies.dart';
import '../../../data/models/custom_country_model.dart';
import '../../../data/providers/firestore_provider.dart';


class CustomCountryController extends GetxController {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final RxList<CustomCountryModel> customCountries = <CustomCountryModel>[].obs;
  final nameController = TextEditingController();
  final capitalController = TextEditingController();
  final regionController = TextEditingController();
  final populationController = TextEditingController();
  final RxBool isLoading = false.obs;
  String? editingId;

  @override
  void onInit() {
    _firestoreProvider.getCustomCountries().listen((snapshot) {
      customCountries.value = snapshot.docs
          .map((doc) => CustomCountryModel.fromFirestore(doc))
          .toList();
    });
    super.onInit();
  }

  Future<void> saveCountry() async {
    isLoading.value = true;
    try {
      final country = {
        'name': nameController.text,
        'capital': capitalController.text,
        'region': regionController.text,
        'population': int.tryParse(populationController.text) ?? 0,
        'createdAt': Timestamp.now(),
      };

      if (editingId == null) {
        await _firestoreProvider.addCustomCountry(country);
      } else {
        await _firestoreProvider.updateCustomCountry(editingId!, country);
      }

      clearForm();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save country: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadFormData(CustomCountryModel? country) {
    if (country != null) {
      editingId = country.id;
      nameController.text = country.name;
      capitalController.text = country.capital;
      regionController.text = country.region;
      populationController.text = country.population.toString();
    } else {
      clearForm();
    }
  }

  void clearForm() {
    editingId = null;
    nameController.clear();
    capitalController.clear();
    regionController.clear();
    populationController.clear();
  }

  Future<void> deleteCountry(String id) async {
    isLoading.value = true;
    try {
      await _firestoreProvider.deleteCustomCountry(id);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete country: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    capitalController.dispose();
    regionController.dispose();
    populationController.dispose();
    super.onClose();
  }
}