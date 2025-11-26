import 'package:flutter/material.dart';
import 'package:wind_main/src/utils/theme/widget_themes/elevated_buton_theme.dart';
import 'package:wind_main/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:wind_main/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:wind_main/src/utils/theme/widget_themes/text_theme.dart';





class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData (
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.LightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.DarkInputDecorationTheme,
  );


  static const Color mint = Color(0xFFD8F3DC);
  static const Color lavender = Color(0xFFD8C1FF);
  static const Color deepLavender = Color(0xFF7559CF);

  // Light theme
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFAF7F0),
    fontFamily: 'Nunito',
    colorScheme: const ColorScheme.light(
      primary: mint,
      secondary: lavender,
    ),
  );

  // Dark theme
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1A1A1D),
    fontFamily: 'Nunito',
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF88E0B3),
      secondary: Color(0xFF9D84FF),
    ),
  );

}