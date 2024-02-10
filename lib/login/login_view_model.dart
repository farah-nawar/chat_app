import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;

  void loginFirebaseAuth(String email, String password) async {
    try {
      navigator.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      navigator.hideLoading();
      navigator.showMessage('Logged in Successfully');

      // retrieve data
      var getuser= await DatabaseUtils.getUser(credential.user?.uid ??'');
      if(getuser ==null){
        navigator.hideLoading();
        navigator.showMessage('please try again');
      }else {
        navigator.navigateToHome();
      }
      print('id: ${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideLoading();
        navigator.showMessage('user-not-found');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideLoading();
        navigator.showMessage('wrong-password');
        print('Wrong password provided for that user.');
      }
    }
  }
}
