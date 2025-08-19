import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChangePasswordController extends GetxController {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  var isLoading = false.obs;

  void changePassword() {
    if (oldPassController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter old password');
      return;
    }
    if (newPassController.text.isEmpty || newPassController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }
    if (newPassController.text != confirmPassController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Success', 'Password changed successfully');
      Get.back();
    });
  }
}
