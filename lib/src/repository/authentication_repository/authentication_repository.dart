import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wind_main/src/exceptions/t_exceptions.dart';
import 'package:wind_main/src/features/authentication/screens/application/home_screen_relations/taskbar_homepage/homepage.dart';
import 'package:wind_main/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:wind_main/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

import '../../features/authentication/screens/email_verification/email_verification.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(firebaseUser.value);
    // ever(firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : user.emailVerified ? Get.offAll(() => const Homepage()) : Get.offAll(() => const MailVerification());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber:phoneNo ,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e){
          if (e.code == 'invalid-phone-number'){
            Get.snackbar('Error', 'The provided phone number is not valid.');
          }
          else {
            Get.snackbar('Error', 'Something went wrong, Try again later.');
          }
        },
        codeSent: (verificationId, resendToken){
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value = verificationId;
        }
    );
  }



 Future <bool> verifyOTP (String otp)async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false ;
  }


  Future<void> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = _auth.currentUser;
      if (user != null) {
        Get.offAll(() => const Homepage());
      }
      else {
        Get.offAll(() => const WelcomeScreen());
      }
    }
    on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE EXCEPTION - ${ex.message}');
      throw ex;
    }
    catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print(' EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e) {}
    catch (_) {
    }
  }

  Future <void> sendEmailVerification()  async {try {
   await _auth.currentUser?.sendEmailVerification();
  }
  on FirebaseAuthException catch (e){
    final ex = TExceptions(e.code);
    throw ex.message;
  }
  catch (_){
    const ex = TExceptions();
    throw ex.message;
  }
  }

  Future<void> logout() async => await _auth.signOut();
}