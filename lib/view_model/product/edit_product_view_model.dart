import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/models/API/edit_product_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/product/product_service.dart';

class EditProductViewModel extends ChangeNotifier {

  EditProductModel addNewProductModel = EditProductModel();

  String? error;

  editProduct(int? id, String tenhanghoa, String dongia, String giaban,
      bool khuyenmai, String loaihanghoa, int nvquet, int idkhachhang) async {

    var result = await ProductService().editProduct(id, tenhanghoa, dongia, giaban,
        khuyenmai, loaihanghoa, nvquet, idkhachhang);
    print(result);

    if(result is Failure) {
      addNewProductModel = EditProductModel();
    }

    if(result is Success) {
      addNewProductModel = result.response as EditProductModel;
      error = '';
    }

    notifyListeners();
  }
}