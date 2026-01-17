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
import 'src/utils/task_enum.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🧠 Hive INIT FIRST
  await Hive.initFlutter();

  // 🔐 Adapters (ALL of them)
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  // 📦 Open boxes BEFORE UI
  await Hive.openBox<Task>('tasks');

  // 🔥 Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthenticationRepository());

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
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),

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
      home: const WelcomeScreen(),
    );
  }
}
