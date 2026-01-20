import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wind_main/src/constants/colors.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/homepage.dart';
import 'package:wind_main/src/features/authentication/screens/profile/update_profile_screen.dart';

import '../../../../constants/text-strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../application/home_screen_relations/task_history/history_screen.dart';
import 'widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Get.offAll(() => Homepage());},
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Text(tProfile, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? LineAwesomeIcons.sun_solid : LineAwesomeIcons.moon_solid,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: AssetImage(tProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: tPrimaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        LineAwesomeIcons.pencil_alt_solid,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                tProfileHeading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                tProfileSubHeading,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const UpdateProfileScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    tEditProfile,
                    style: TextStyle(color: tDarkColor),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              FileMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog_solid,
                OnPress: () {},
              ),

              FileMenuWidget(
                title: "History",
                OnPress: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
                },
                icon: LineAwesomeIcons.info_solid,
              ),

              FileMenuWidget(
                title: "Logout",
                OnPress: () {
                  AuthenticationRepository.instance.logout();
                },
                icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor: Colors.red,
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
