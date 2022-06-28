import 'package:flutter/foundation.dart';
import 'package:qr_code_app/models/API/get_all_departments_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/department/department_service.dart';


class GetAllDepartmentsViewModel extends ChangeNotifier {

  GetAllDepartmentsModel getAllDepartmentModel = GetAllDepartmentsModel();

  getAllDepartments() async {
    var result = await DepartmentService().getAllDepartments();

    if (result is Failure) {
      getAllDepartmentModel = GetAllDepartmentsModel();
    }

    if (result is Success) {
      getAllDepartmentModel = result.response as GetAllDepartmentsModel;
    }

    notifyListeners();
  }
}