import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

// light and dark themes

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style:ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      backgroundColor: tSecondaryColor,
      side: BorderSide(color:tSecondaryColor,),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
      elevation: 0,
    ) ,
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style:ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      backgroundColor: tWhiteColor,
      side: BorderSide(color:tSecondaryColor,),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
      elevation: 0,
    ) ,
  );
}

