// class Product {
//   final String? id;
//   final String? tenhanghoa;
//   final int? giaban;
//   final int? dongia;
//   final bool? khuyenmai;
//
//   Product({required this.id, required this.tenhanghoa, required this.giaban, required this.dongia, required this.khuyenmai});
// }
import 'package:intl/intl.dart';

class Employee {
  int? employeesId;
  String? username;
  String? password;
  String? manv;
  String? hoten;
  DateTime? ngaysinh;
  int? gioitinh;
  String? sdt;
  int? departmentsId;

  Employee(
      {this.employeesId,
        this.username,
        this.password,
        this.manv,
        this.hoten,
        this.ngaysinh,
        this.gioitinh,
        this.sdt,
        this.departmentsId});

  Employee.fromJson(Map<String, dynamic> json) {
    employeesId = json['employees_id'];
    username = json['username'];
    password = json['password'];
    manv = json['manv'];
    hoten = json['hoten'];
    ngaysinh = json['ngaysinh'];
    gioitinh = json['gioitinh'];
    sdt = json['sdt'];
    departmentsId = json['departments_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employees_id'] = this.employeesId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['manv'] = this.manv;
    data['hoten'] = this.hoten;
    data['ngaysinh'] = this.ngaysinh;
    data['gioitinh'] = this.gioitinh;
    data['sdt'] = this.sdt;
    data['departments_id'] = this.departmentsId;
    return data;
  }
}