import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/features/authentication/screens/profile/profile_screen.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: (){Get.to(() => ProfileScreen());},
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(tProfileImage)
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hey George',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Let’s plan your day',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
