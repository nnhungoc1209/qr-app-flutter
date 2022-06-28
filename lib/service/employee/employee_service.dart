import 'package:dio/dio.dart';
import 'package:qr_code_app/models/API/get_all_employee_model.dart';
import 'package:qr_code_app/service/api_status.dart';

class EmployeeService {
  Future<Object> getAllEmployees() async {
    var getAllEmployeesModel = GetAllEmployeeModel();
    try {
      Dio dio = Dio();
      var response = await dio.get('http://192.168.1.14:8000/api/employees');
      print(response.toString());

      if(response.data != null && response.statusCode == 200) {
        getAllEmployeesModel = GetAllEmployeeModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: getAllEmployeesModel
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
