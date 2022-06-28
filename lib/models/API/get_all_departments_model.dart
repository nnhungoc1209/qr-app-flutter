import 'package:qr_code_app/models/department_model.dart';

class GetAllDepartmentsModel {
  List<Department>? data;

  GetAllDepartmentsModel({this.data});

  GetAllDepartmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Department>[];
      json['data'].forEach((v) {
        data!.add(Department.fromJson(v));
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