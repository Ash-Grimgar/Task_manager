import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/helper_utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';


class MailVerificationController extends GetxController {
late Timer _timer;
  @override
void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
}

Future<void> sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    }
    catch (e){
      Helper.errorSnackBar(title : "Error", message: e.toString());
    }


}

void setTimerForAutoRedirect(){
    _timer = Timer.periodic(Duration(seconds: 3), (timer){
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified){
        timer.cancel();
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    });

}

void manuallyCheckEmailVerificationStatus(){}

}

class Helper {
  static void errorSnackBar({required String title, required String message}) {}
}