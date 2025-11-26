import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wind_main/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:wind_main/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:wind_main/src/constants/colors.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/constants/text-strings.dart';
import 'package:wind_main/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final controller = Get.put(FadeInAnimationController());
    // controller.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(durationInMs: 1600,
              animate: TAnimatePosition(
                topAfter: 0,
                topBefore: -30,
                leftBefore: -30,
                leftAfter: -10,
              ),
              child: SvgPicture.asset(tSplashTopIcon, height: 150,)),
          TFadeInAnimation(
                  durationInMs: 2400,
                  animate:TAnimatePosition(topBefore: 0, topAfter: 200, ),
                  child: Image(image: AssetImage(tSPlashImage), height: 300),
            ),
          TFadeInAnimation( durationInMs: 2000,
                animate: TAnimatePosition(topBefore: 500, topAfter: 500, leftAfter: tDefaultSize, leftBefore: -80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tAppName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      tAppTagLine,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),


          ),

          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(
              bottomAfter: 60,
              bottomBefore: 0,
              rightBefore: 0,
              rightAfter: 0,
            ),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                color: tPrimaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
