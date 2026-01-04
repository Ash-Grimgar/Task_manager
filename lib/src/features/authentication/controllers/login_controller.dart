import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wind_main/src/constants/text-strings.dart';
import 'package:wind_main/src/features/authentication/controllers/email_verification_%20controller.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/homepage.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';


class LoginController extends GetxController {
  // Variable to hold password visibility state
  final isPasswordObscured = true.obs;

  // Controllers to access text field values and trim them
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Function to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  // A method to get the trimmed email value
  String get trimmedEmail => emailController.text.trim();

  // A method to get the trimmed password value
  String get trimmedPassword => passwordController.text.trim();

  // It's good practice to close controllers when the widget is disposed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;

  /// Email and Password login
  Future<void> Login() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      Get.offAll(Homepage());
    } catch (e) {
      isLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }
}
