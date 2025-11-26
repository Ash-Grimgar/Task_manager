import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text-strings.dart';
import '../../models/model_on_boarding.dart';



class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Image(image: AssetImage(model.image), height: model.height * 0.4,),
          Column(
            children: [
              Text(tOnBoardingTitle1, style: Theme.of(context).textTheme.headlineLarge,),
              Text(tOnBoardingSubTitle1, textAlign: TextAlign.center,),
            ],
          ),
          Text(tOnboardingCounter1, style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: 80,)
        ],
      ),
    );
  }
}
