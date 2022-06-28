import 'package:flutter/material.dart';
import 'package:qr_code_app/models/API/delete_product_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/product/product_service.dart';

class DeleteProductViewModel extends ChangeNotifier {

  DeleteProductModel deleteProductModel = DeleteProductModel();

  deleteProduct(int id) async {
    var result = await ProductService().deleteProduct(id);

    if (result is Failure) {
      deleteProductModel = DeleteProductModel();
    }

    if (result is Success) {
      deleteProductModel = result.response as DeleteProductModel;
    }

    notifyListeners();
  }
}