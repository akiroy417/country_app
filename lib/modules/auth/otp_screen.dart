import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  final AuthController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final verificationId = Get.arguments as String;
    _controller.verificationId.value = verificationId;

    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to your phone'),
            SizedBox(height: 20),
            TextField(
              controller: _controller.otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Obx(() => _controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _controller.verifyOtp,
              child: Text('Verify'),
            )),
          ],
        ),
      ),
    );
  }
}