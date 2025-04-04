import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'core/routes.dart';
import 'core/bindings.dart';
import 'modules/home/controllers/theme_controller.dart'; // Import ThemeController

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize ThemeController instance
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'Countries App',
          theme: themeController.isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: '/login', // Ensure this route exists in routes.dart
          getPages: AppRoutes.routes,
          initialBinding: InitialBindings(), // Automatically inject dependencies
        );
      },
    );
  }
}
