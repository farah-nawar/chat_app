/// Interface between UI and ViewModel
abstract class RegisterNavigator{
  /// ABSTRACT METHODS
  void showLoading();
  void hideLoading();
  void showMessage(String message);
}