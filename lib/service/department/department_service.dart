import 'package:dio/dio.dart';
import 'package:qr_code_app/models/API/get_all_departments_model.dart';
import 'package:qr_code_app/service/api_status.dart';

class DepartmentService {
  Future<Object> getAllDepartments() async {
    var getAllDepartmentsModel = GetAllDepartmentsModel();
    try {
      Dio dio = Dio();
      var response = await dio.get('http://192.168.1.14:8000/api/departments');
      print(response.toString());

      if(response.data != null && response.statusCode == 200) {
        getAllDepartmentsModel = GetAllDepartmentsModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: getAllDepartmentsModel
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
