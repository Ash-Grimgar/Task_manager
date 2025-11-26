import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wind_main/src/constants/sizes.dart';
import 'package:wind_main/src/constants/text-strings.dart';

import '../../../controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otp ;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tOtpTitle , style: GoogleFonts.montserrat(fontSize: 80,fontWeight: FontWeight.bold,),),
            Text(tOtpSUbTitle.toUpperCase(),style: Theme.of(context).textTheme.headlineSmall,),
            Text("$tOtpMessage+support@codingwithT.com",textAlign: TextAlign.center ,),
            const SizedBox(height: 20.0,),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code){
                otp = code;
                OTPController.instance.verifyOTP(otp);
              },
            ),
            const SizedBox(height: 20.0,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  OTPController.instance.verifyOTP(otp);
                }, child: Text(tNext))),
          ],
        ),
      ),
    );
  }
}
