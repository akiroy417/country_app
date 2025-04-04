import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/custom_country_model.dart';
import '../../core/constants.dart';

class CustomCountryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CustomCountryModel>> getCustomCountries() {
    return _firestore
        .collection(AppConstants.customCountriesCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CustomCountryModel.fromFirestore(doc))
        .toList());
  }

  Future<void> addCustomCountry(CustomCountryModel country) async {
    try {
      await _firestore
          .collection(AppConstants.customCountriesCollection)
          .add(country.toMap());
    } catch (e) {
      Get.snackbar('Error', 'Failed to add country: $e');
      rethrow;
    }
  }

  Future<void> updateCustomCountry(String id, CustomCountryModel country) async {
    try {
      await _firestore
          .collection(AppConstants.customCountriesCollection)
          .doc(id)
          .update(country.toMap());
    } catch (e) {
      Get.snackbar('Error', 'Failed to update country: $e');
      rethrow;
    }
  }

  Future<void> deleteCustomCountry(String id) async {
    try {
      await _firestore
          .collection(AppConstants.customCountriesCollection)
          .doc(id)
          .delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete country: $e');
      rethrow;
    }
  }
}