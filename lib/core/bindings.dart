import 'package:get/get.dart';

import '../data/repositories/auth_repository.dart';
import '../data/repositories/user_repository.dart';
import '../modules/auth/auth_controller.dart';
import '../modules/home/controllers/country_controller.dart';
import '../modules/home/controllers/custom_country_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(CountryController(), permanent: true);
    Get.put(CustomCountryController(), permanent: true);
  }
}
