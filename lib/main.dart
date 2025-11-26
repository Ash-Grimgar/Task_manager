import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wind_main/firebase_options.dart';
import 'package:wind_main/src/constants/colors.dart';
import 'package:wind_main/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:wind_main/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:wind_main/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';

// import 'package:wind_main/src/utils/theme/widget_themes/theme.dart';
// import 'package:wind_main/src/features/authentication/screens/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: tPrimaryColor,
        appBarTheme: AppBarTheme(backgroundColor: tPrimaryColor),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: WelcomeScreen(),
    );
  }
}