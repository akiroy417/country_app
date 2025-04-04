import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/dependencies.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../utlis/validators.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = Get.find();
  final UserRepository _userRepo = Get.find();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final Rx<User?> firebaseUser = Rx<User?>(null);
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final RxString verificationId = ''.obs;
  final RxBool isLoading = false.obs;
  XFile? profileImage;

  @override
  void onInit() {
    firebaseUser.bindStream(_authRepo.authStateChanges());
    ever(firebaseUser, _handleAuthStateChange);
    super.onInit();
  }

  void _handleAuthStateChange(User? user) async {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      final userData = await _userRepo.getUserData(user.uid);
      if (userData == null) {
        nameController.text = user.displayName ?? '';
        emailController.text = user.email ?? '';
        Get.offAllNamed('/profile/edit');
      } else {
        currentUser.value = userData;
        Get.offAllNamed('/home');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      firebaseUser.value = await _authRepo.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyPhone() async {
    isLoading.value = true;
    try {
      String phone = phoneController.text.trim(); // ✅ Trim input
      if (AppValidators.validatePhone(phone) != null) {
        Get.snackbar('Error', AppValidators.validatePhone(phone)!);
        return;
      }

      await _authRepo.verifyPhoneNumber(
        phoneNumber: phone, // ✅ Ensure correct format
        onCodeSent: (verificationId) {
          this.verificationId.value = verificationId;
          Get.toNamed('/otp');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> verifyOtp() async {
    isLoading.value = true;
    try {
      firebaseUser.value = await _authRepo.verifyOtp(
        verificationId.value,
        otpController.text,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    profileImage = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    try {
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await _userRepo.uploadProfileImage(
          firebaseUser.value!.uid,
          profileImage!.path,
        );
      }

      final userModel = UserModel(
        uid: firebaseUser.value!.uid,
        name: nameController.text,
        email: emailController.text,
        phone: firebaseUser.value!.phoneNumber ?? phoneController.text,
        photoUrl: imageUrl ?? firebaseUser.value!.photoURL,
      );

      await _authRepo.saveUserData(userModel.toMap());
      currentUser.value = userModel;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
    firebaseUser.value = null;
    currentUser.value = null;
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
