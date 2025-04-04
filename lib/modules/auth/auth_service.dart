import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  int? _resendToken;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      final verificationParams = {
        'phoneNumber': phoneNumber,
        'verificationCompleted': _onVerificationCompleted,
        'verificationFailed': _onVerificationFailed,
        'codeSent': _onCodeSent,
        'codeAutoRetrievalTimeout': _onCodeTimeout,
        'forceResendingToken': _resendToken,
        'timeout': const Duration(seconds: 60),
      };

      // Web-specific parameters
      if (kIsWeb) {
        verificationParams.addAll({
          'recaptchaVerificationCompleted': (verificationId) {
            _verificationId = verificationId;
            Get.snackbar('Success', 'reCAPTCHA verification completed');
          },
          'recaptchaVerificationFailed': (error) {
            Get.snackbar('Error', 'reCAPTCHA verification failed: ${error.message}');
          },
        });
      }

      await _auth.verifyPhoneNumber( verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  }, verificationFailed: (FirebaseAuthException error) {  }, codeSent: (String verificationId, int? forceResendingToken) {  }, codeAutoRetrievalTimeout: (String verificationId) {  });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ... rest of your AuthService methods remain the same ...
  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Auto verification failed: ${e.toString()}');
    }
  }

  void _onVerificationFailed(FirebaseAuthException error) {
    Get.snackbar('Verification Failed', error.message ?? 'Unknown error');
  }

  void _onCodeSent(String verificationId, int? resendToken) {
    _verificationId = verificationId;
    _resendToken = resendToken;
    Get.toNamed('/verify-otp');
  }

  void _onCodeTimeout(String verificationId) {
    _verificationId = verificationId;
  }

  Future<void> verifyOTP(String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP code: ${e.toString()}');
    }
  }
}