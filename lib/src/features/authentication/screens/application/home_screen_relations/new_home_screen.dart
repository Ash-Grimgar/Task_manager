import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/about_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AboutWidget()],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(image: AssetImage(tProfileImage)),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Hi George!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [Icon(Icons.more_vert, color: Colors.black, size: 40)],
    );
  }
}
