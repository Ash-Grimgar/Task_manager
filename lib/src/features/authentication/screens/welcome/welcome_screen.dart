import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wind_main/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:wind_main/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:wind_main/src/constants/colors.dart';
// import 'package:wind_main/src/constants/colors.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/constants/text-strings.dart';
import 'package:wind_main/src/features/authentication/screens/SignUp/signup_screen.dart';
import 'package:wind_main/src/features/authentication/screens/login/login_screen.dart';

import '../../../../common_widgets/fade_in_animation/fade_in_animation_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    var mediaQuery= MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness ==Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1200,
            animate: TAnimatePosition(bottomAfter: 0, bottomBefore: -100,
              leftBefore: 0,
              leftAfter: 0,
              rightBefore: 0,
              rightAfter: 0,
              topAfter: 0,
              topBefore: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage(tWelcomeScreenImage), height: height*0.4),
                  Column(
                    children: [
                      Text(
                        tWelcomeTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        tWelcomeSubTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
            
                          onPressed: () {Get.to(LoginScreen());},
                          child: Text(tLogin.toUpperCase()),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
            
                          onPressed: () {Get.to(SignupScreen());},
                          child: Text(tSignUp.toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
