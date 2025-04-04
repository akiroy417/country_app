import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/custom_country_controller.dart';

class AddEditCountryScreen extends StatelessWidget {
  final CustomCountryController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.editingId == null ? 'Add Country' : 'Edit Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controller.nameController,
                decoration: InputDecoration(labelText: 'Country Name'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Required field' : null,
              ),
              TextFormField(
                controller: _controller.capitalController,
                decoration: InputDecoration(labelText: 'Capital'),
              ),
              TextFormField(
                controller: _controller.regionController,
                decoration: InputDecoration(labelText: 'Region'),
              ),
              TextFormField(
                controller: _controller.populationController,
                decoration: InputDecoration(labelText: 'Population'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Obx(() => _controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _controller.saveCountry,
                child: Text('Save'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}