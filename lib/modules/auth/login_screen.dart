import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller.phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Obx(() => _controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _controller.verifyPhone,
              child: Text('Send OTP'),
            )),
            SizedBox(height: 20),
            Divider(),
            Obx(() => _controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
              onPressed: _controller.signInWithGoogle,
              icon: Icon(Icons.g_mobiledata),
              label: Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            )),
          ],
        ),
      ),
    );
  }
}