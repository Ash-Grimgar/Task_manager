import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'src/constants/colors.dart';
import 'src/features/authentication/screens/welcome/welcome_screen.dart';
import 'src/repository/authentication_repository/authentication_repository.dart';
import 'src/features/authentication/models/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthenticationRepository());

  // 🧠 Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: tPrimaryColor,
        scaffoldBackgroundColor: tPrimaryColor,
        appBarTheme: AppBarTheme(backgroundColor: tPrimaryColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const WelcomeScreen(),
    );
  }
}
