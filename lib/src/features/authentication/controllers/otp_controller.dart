import 'package:get/get.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/homepage.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(()=>const Homepage()):Get.back();
  }
}