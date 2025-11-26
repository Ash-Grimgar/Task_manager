import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme LightInputDecorationTheme  =
      InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
 prefixIconColor: tSecondaryColor,
  labelStyle: const TextStyle(color: tSecondaryColor),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
  borderSide: const BorderSide(width: 2.0, color: tSecondaryColor)
  ),
  );



  static InputDecorationTheme DarkInputDecorationTheme  =
  InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: tPrimaryColor,
    labelStyle: TextStyle(color: tPrimaryColor),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(width: 2.0, color: tSecondaryColor)
    ),
  );
}