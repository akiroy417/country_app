import 'package:taskcountryapp/utlis/extensions.dart';

class AppValidators {
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';

    // Ensure number starts with "+" followed by country code and digits
    if (!RegExp(r'^\+[1-9]\d{6,14}$').hasMatch(value)) {
      return 'Enter a valid phone number in E.164 format (e.g., +919876543210)';
    }

    return null;
  }


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.isValidEmail()) return 'Enter a valid email';
    return null;
  }

  static String? validatePopulation(String? value) {
    if (value == null || value.isEmpty) return 'Population is required';
    if (int.tryParse(value) == null) return 'Enter a valid number';
    return null;
  }
}