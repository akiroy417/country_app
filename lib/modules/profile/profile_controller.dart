import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';
import '../auth/auth_controller.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepo = Get.find();
  final AuthController _authController = Get.find();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final photoUrl = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    _loadUserData();
    super.onInit();
  }

  void _loadUserData() {
    final user = _authController.currentUser.value;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
      photoUrl.value = user.photoUrl ?? '';
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isLoading.value = true;
      try {
        final downloadUrl = await _userRepo.uploadProfileImage(
            _authController.currentUser.value!.uid,
            pickedFile.path
        );
        photoUrl.value = downloadUrl ?? '';
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final updatedUser = UserModel(
        uid: _authController.currentUser.value!.uid,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        photoUrl: photoUrl.value,
      );

      await _userRepo.updateUser(updatedUser);
      _authController.currentUser.value = updatedUser;
      Get.back();
      Get.snackbar('Success', 'Profile updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}