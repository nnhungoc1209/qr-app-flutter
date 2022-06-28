import 'package:flutter/material.dart';
import 'package:qr_code_app/models/API/login_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/auth/auth_service.dart';

class LoginViewModel extends ChangeNotifier {

  LoginModel loginModel = LoginModel();
  String? error;

  login(String username, String password) async {
    var result = await AuthService().login(username, password);

    if (result is Failure) {
      loginModel = LoginModel();
    }

    if (result is Success) {
      loginModel = result.response as LoginModel;
      error = '';
    }

    notifyListeners();
  }
}