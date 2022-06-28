import 'package:flutter/foundation.dart';
import 'package:qr_code_app/models/API/get_all_employee_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/employee/employee_service.dart';


class GetAllEmployeesViewModel extends ChangeNotifier {

  GetAllEmployeeModel getAllEmployeeModel = GetAllEmployeeModel();

  getAllEmployees() async {
    var result = await EmployeeService().getAllEmployees();

    if (result is Failure) {
      getAllEmployeeModel = GetAllEmployeeModel();
    }

    if (result is Success) {
      getAllEmployeeModel = result.response as GetAllEmployeeModel;
    }

    notifyListeners();
  }
}