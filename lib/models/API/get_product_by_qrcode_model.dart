import 'package:qr_code_app/models/product_model.dart';

class GetProductByQrCodeModel {
  List<Product>? data;

  GetProductByQrCodeModel({this.data});

  GetProductByQrCodeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
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