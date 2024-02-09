import 'package:chat_app/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Provider
class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void registerfirebaseAuth(String email, String password) async {
    /// show loading
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Firebase auth id: ${credential.user?.uid}');
      navigator.hideLoading();
      navigator.showMessage('Registered Successfully');
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
