import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final AuthController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _controller.pickImage,
              child: Obx(() {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: _controller.profileImage != null
                      ? FileImage(File(_controller.profileImage!.path))
                      : _controller.currentUser.value?.photoUrl != null
                      ? NetworkImage(
                      _controller.currentUser.value!.photoUrl!)
                      : null,
                  child: _controller.profileImage == null &&
                      _controller.currentUser.value?.photoUrl == null
                      ? Icon(Icons.person, size: 50)
                      : null,
                );
              }),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _controller.nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _controller.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Obx(() => _controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _controller.saveProfile,
              child: Text('Save Profile'),
            )),
          ],
        ),
      ),
    );
  }
}