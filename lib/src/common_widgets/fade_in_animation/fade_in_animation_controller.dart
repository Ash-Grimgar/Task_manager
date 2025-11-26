
import 'package:get/get.dart';
import 'package:wind_main/src/features/authentication/screens/welcome/welcome_screen.dart';


class FadeInAnimationController extends GetxController{
  static FadeInAnimationController get find => Get.find();

 RxBool animate = false.obs;

  Future startSplashAnimation ()async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 3000));
  Get.offAll(()=>const WelcomeScreen());

  }


  Future startAnimation ()async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }
}