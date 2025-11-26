import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wind_main/src/features/authentication/controllers/login_controller.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen.dart';
import 'package:wind_main/src/features/authentication/screens/forget_password/forget_password_options/forget_password-model_bottom_sheet.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text-strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: tFormHeight),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordObscured.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => controller.togglePasswordVisibility(),
                    icon: Icon(
                      controller.isPasswordObscured.value
                          ? Icons.remove_red_eye_sharp
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: Text(tForgotPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: () {Get.offAll(DoodleTaskManagerApp());},
                onPressed: () => controller.Login(),
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
