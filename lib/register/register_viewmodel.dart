import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Provider
class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void registerfirebaseAuth(String email, String password, String firstname,String lastname, String username) async {
    /// show loading
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Firebase auth id: ${credential.user?.uid}');
      // save data
      var user= MyUsers(id: credential.user?.uid ?? '',
          username: username,
          email: email,
          firstname: firstname,
          lastname: lastname);
      var dataUser= await DatabaseUtils.registeruser(user);


      navigator.hideLoading();
      navigator.showMessage('Registered Successfully');
      navigator.navigateToHome();
      /// stop loading
      /// message that is done
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage('Something went wrong');
      print(e);
    }
  }
}
