import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';
import 'controllers/country_controller.dart';
import 'controllers/custom_country_controller.dart';
import 'controllers/theme_controller.dart'; // Import ThemeController
import 'widgets/country_card.dart';
import 'widgets/custom_country_card.dart';

class HomeScreen extends StatelessWidget {
  final CountryController _countryController = Get.find();
  final CustomCountryController _customController = Get.find();
  final AuthController _authController = Get.find();
  final ThemeController _themeController = Get.find(); // Get ThemeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _customController.loadFormData(null);
              Get.toNamed('/country/add');
            },
          ),
          IconButton(
            icon: Obx(() => Icon(_countryController.sortOrder.value == 'asc'
                ? Icons.arrow_upward
                : Icons.arrow_downward)),
            onPressed: _countryController.toggleSortOrder,
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
          ),
          // 🌗 Theme Toggle Button
          Obx(() {
            return IconButton(
              icon: Icon(
                _themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: _themeController.toggleTheme,
            );
          }),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _authController.logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _countryController.searchQuery,
              decoration: InputDecoration(
                labelText: 'Search Countries',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_countryController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: _countryController.filteredCountries.length +
                    _customController.customCountries.length,
                itemBuilder: (context, index) {
                  if (index < _countryController.filteredCountries.length) {
                    final country = _countryController.filteredCountries[index];
                    return CountryCard(country: country);
                  } else {
                    final customIndex =
                        index - _countryController.filteredCountries.length;
                    final customCountry =
                    _customController.customCountries[customIndex];
                    return CustomCountryCard(
                      country: customCountry,
                      onEdit: () {
                        _customController.loadFormData(customCountry);
                        Get.toNamed('/country/edit');
                      },
                      onDelete: () =>
                          _customController.deleteCountry(customCountry.id!),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
