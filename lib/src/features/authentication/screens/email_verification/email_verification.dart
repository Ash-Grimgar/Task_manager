import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/features/authentication/controllers/email_verification_%20controller.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: tDefaultSize * 5,
            left: tDefaultSize * 2,
            right: tDefaultSize,
            bottom: tDefaultSize * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LineAwesomeIcons.envelope_open, size: 100),
              const SizedBox(height: tDefaultSize * 2),
              Text("", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: tDefaultSize * 2),
              Text(
                "",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: tDefaultSize * 2),
              SizedBox(
                width: 260,
                child: OutlinedButton(
                  onPressed: () =>
                      controller.manuallyCheckEmailVerificationStatus,
                  child: Text("Continue".tr),
                ),
              ),
              const SizedBox(height: tDefaultSize * 2),
              TextButton(
                onPressed: () => controller.sendVerificationEmail(),
                child: Text("Resend Email link".tr),
              ),
              TextButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LineAwesomeIcons.long_arrow_alt_left_solid),
                    const SizedBox(width: 5),
                    Text("Back to login".tr.toLowerCase()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
