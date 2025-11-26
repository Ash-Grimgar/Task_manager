import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wind_main/src/repository/authentication_repository/authentication_repository.dart';
import 'package:wind_main/src/repository/user_repository/user_repository.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController{
  static ProfileController  get Instance => Get.find ();


  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  // Step 3  - Get user Email and pass to USerRepository to fetch user record.
getUserData(){
 final email = _authRepo.firebaseUser.value?.email;
 if (email!=null){
   return _userRepo.getUserDetails(email);
 }
 else {Get.snackbar("Error","Login to continue");}
}

updateRecord(UserModel user) async{
  await _userRepo.updateUserRecord(user);

}

}