import '../model/myuser.dart';

/// Interface between UI and ViewModel
abstract class RegisterNavigator{
  /// ABSTRACT METHODS
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUsers users);
}