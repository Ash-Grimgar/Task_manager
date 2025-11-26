// Step 1 [Creating a user model]
// steps in storing data in firebase


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String ? id ;
  final String fullName ;
  final String email;
  final String phoneNo ;
  final String password ;


  const UserModel ({
    this.id,
    required this.password,
    required this.email,
    required this.phoneNo,
    required this.fullName,
});

toJson (){
  return {
    'fullName' : fullName,
    'email' : email,
    'phoneNo' : phoneNo,
    'password' : password,
  };
  }
  // Step 1 - Map user fetched from firebase to user model

factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
  final data = document.data()!;
  return UserModel(password: data["Password"], email: data["Email"], phoneNo: data["Phone"], fullName: data["FullName"], id: document.id);
}
}
