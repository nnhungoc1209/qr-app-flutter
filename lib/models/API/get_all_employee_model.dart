import 'package:qr_code_app/models/employee_model.dart';

class GetAllEmployeeModel {
  List<Employee>? data;

  GetAllEmployeeModel({this.data});

  GetAllEmployeeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Employee>[];
      json['data'].forEach((v) {
        data!.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}