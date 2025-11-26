import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wind_main/src/constants/colors.dart';

class TTextTheme{
    TTextTheme._();// To avoid creating instances


// Light Text Theme

static TextTheme lightTextTheme = TextTheme (
      displayLarge : GoogleFonts.playfairDisplay (fontSize:24.0 , color: tDarkColor ),
  displayMedium : GoogleFonts.lato (fontSize:24.0 , fontWeight: FontWeight.w700, color: tDarkColor ),
  displaySmall : GoogleFonts.lato (fontSize:24.0 , fontWeight: FontWeight.w700, color: tDarkColor ),
  headlineLarge: GoogleFonts.poppins (fontSize:16.0 , fontWeight: FontWeight.w600, color: tDarkColor ),
  headlineMedium : GoogleFonts.jacquard12 (fontSize:14.0 , fontWeight: FontWeight.w600, color: tDarkColor ),
  // headlineMedium : GoogleFonts.poppins (fontSize:14.0 , fontWeight: FontWeight.normal, color: tDarkColor ),
  // headlineMedium : GoogleFonts.poppins (fontSize:14.0 , fontWeight: FontWeight.normal, color: tDarkColor ),

      );

  static TextTheme darkTextTheme = TextTheme (
      displayLarge : GoogleFonts.playfairDisplay (fontSize:24.0 , fontWeight: FontWeight.bold, color: tWhiteColor ),
      displayMedium : GoogleFonts.lato(fontSize:24.0 , fontWeight: FontWeight.w700, color:  tWhiteColor ),
      displaySmall : GoogleFonts.poppins (fontSize:24.0 , fontWeight: FontWeight.w700, color:  tWhiteColor ),
      headlineLarge : GoogleFonts.poppins (fontSize:16.0 , fontWeight: FontWeight.w600, color:  tWhiteColor ),
      headlineMedium : GoogleFonts.poppins (fontSize:14.0 , fontWeight: FontWeight.w600, color:  tWhiteColor ),
      // headline4 : GoogleFonts.poppins (fontSize:14.0 , fontWeight: FontWeight.normal, color:  tWhiteColor ),
      // headline4 : GoogleFonts.poppins (fontSize:14.0 , fontWeight: FontWeight.normal, color:  tWhiteColor ),
  );
}