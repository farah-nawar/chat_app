import 'package:chat_app/model/myuser.dart';

/// Interface between UI and ViewModel
abstract class LoginNavigator{
  /// ABSTRACT METHODS
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUsers users);
}