import 'package:get/get.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/home/controllers/country_controller.dart';
import '../modules/auth/login_screen.dart';
import '../modules/auth/otp_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/home/add_edit_country_screen.dart';
import '../modules/profile/edit_profile_screen.dart';
import '../modules/profile/profile_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(), // Ensures AuthController is ready
    ),
    GetPage(
      name: '/otp',
      page: () => OtpScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthBinding()); // Ensure dependencies are available for OTP
      }),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(CountryController()); // Ensure country data is available
      }),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthBinding()); // Ensure AuthController is available
      }),
    ),
    GetPage(
      name: '/profile/edit',
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: '/country/add',
      page: () => AddEditCountryScreen(),
    ),
    GetPage(
      name: '/country/edit',
      page: () => AddEditCountryScreen(),
    ),
  ];
}
