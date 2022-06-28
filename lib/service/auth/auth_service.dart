import 'package:dio/dio.dart';
import 'package:qr_code_app/models/API/login_model.dart';

import 'package:qr_code_app/service/api_status.dart';

class AuthService {
  Future<Object> login(String username, String password) async {
    var loginModel = LoginModel();

    var params = {
      'username': username,
      'password': password
    };

    try {
      Dio dio = Dio();
      var response = await dio.post('http://192.168.1.14:8000/api/login', data: params);
      print(response.toString());

      if(response.data != null && response.statusCode == 201) {
        loginModel = LoginModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: loginModel
      );
    }
    on DioError catch (e) {
      return Failure(
          code: e.response?.statusCode,
          errorResponse: e.toString()
      );
    }
  }
}