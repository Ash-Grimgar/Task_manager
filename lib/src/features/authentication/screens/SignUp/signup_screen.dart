import 'package:flutter/material.dart';
import 'package:wind_main/src/common_widgets/form/form_header_widget.dart';
import 'package:wind_main/src/constants/image_strings.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/constants/text-strings.dart';
import 'package:wind_main/src/features/authentication/screens/SignUp/widgets/signup_form_widget.dart';

import '../../../../constants/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                ),
                SignUpFormWidget(),
                Column(
                  children: [
                    const Text("OR"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage(tGoogleLogoImage),
                          width: 20.0,
                        ),
                        label: Text(tSignInWithGoogle.toUpperCase()),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: tAlreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(text: tLogin.toUpperCase()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
