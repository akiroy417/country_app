import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../core/constants.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCustomCountry(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(AppConstants.customCountriesCollection).add(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add country: $e');
      throw e;
    }
  }

  Stream<QuerySnapshot> getCustomCountries() {
    return _firestore
        .collection(AppConstants.customCountriesCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateCustomCountry(String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(AppConstants.customCountriesCollection).doc(id).update(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update country: $e');
      throw e;
    }
  }

  Future<void> deleteCustomCountry(String id) async {
    try {
      await _firestore.collection(AppConstants.customCountriesCollection).doc(id).delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete country: $e');
      throw e;
    }
  }

  Future<void> saveUserData(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(data['uid']).set(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save user data: $e');
      throw e;
    }
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection(AppConstants.usersCollection).doc(uid).get();
  }
}