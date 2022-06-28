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

class Product {
  int? productsId;
  String? maqr;
  String? mahanghoa;
  String? tenhanghoa;
  String? dongia;
  String? giaban;
  int? khuyenmai;
  String? loaihanghoa;
  DateTime? ngayquet;
  double? toadox;
  double? toadoy;
  int? employeesId;
  int? customersId;

  Product(
      {this.productsId,
        this.maqr,
        this.mahanghoa,
        this.tenhanghoa,
        this.dongia,
        this.giaban,
        this.khuyenmai,
        this.loaihanghoa,
        this.ngayquet,
        this.toadox,
        this.toadoy,
        this.employeesId,
        this.customersId});

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    maqr = json['maqr'];
    mahanghoa = json['mahanghoa'];
    tenhanghoa = json['tenhanghoa'];
    dongia = json['dongia'];
    giaban = json['giaban'];
    khuyenmai = json['khuyenmai'];
    loaihanghoa = json['loaihanghoa'];
    ngayquet = DateFormat('dd-MM-yyyy HH:mm').parse(json['ngayquet']);
    toadox = json['toadox'];
    toadoy = json['toadoy'];
    employeesId = json['employees_id'];
    customersId = json['customers_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    data['maqr'] = this.maqr;
    data['mahanghoa'] = this.mahanghoa;
    data['tenhanghoa'] = this.tenhanghoa;
    data['dongia'] = this.dongia;
    data['giaban'] = this.giaban;
    data['khuyenmai'] = this.khuyenmai;
    data['loaihanghoa'] = this.loaihanghoa;
    data['ngayquet'] = this.ngayquet;
    data['toadox'] = this.toadox;
    data['toadoy'] = this.toadoy;
    data['employees_id'] = this.employeesId;
    data['customers_id'] = this.customersId;
    return data;
  }
}