import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wind_main/src/constants/text-strings.dart';
import 'package:wind_main/src/features/authentication/models/user_model.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Get.back(),
          child: Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  final email = TextEditingController(text: userData.email);
                  final password = TextEditingController(text: userData.password);
                  final fullName = TextEditingController(text: userData.fullName);
                  final phoneNo = TextEditingController(text: userData.phoneNo);

                  return Column(
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
                                LineAwesomeIcons.camera_solid,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: phoneNo,
                              decoration: const InputDecoration(
                                label: Text(tPhoneNo),
                                prefixIcon: Icon(Icons.numbers),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller:password,
                              decoration: const InputDecoration(
                                label: Text(tPassword),
                                prefixIcon: Icon(Icons.fingerprint),
                              ),
                            ),

                            const SizedBox(height: tFormHeight),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async{
                                  final userData = UserModel(
                                    password: password.text.trim(),
                                    email: email.text.trim(),
                                    phoneNo: phoneNo.text.trim(),
                                    fullName: fullName.text.trim(),
                                  );
                                  await controller.updateRecord(userData);
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
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
