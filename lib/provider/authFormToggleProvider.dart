import 'package:flutter/foundation.dart';

class AuthFormToggleProvider extends ChangeNotifier {
  bool isLoginForm = false;

  void toggleForm() {
    isLoginForm = !isLoginForm;
    notifyListeners();
  }
}
