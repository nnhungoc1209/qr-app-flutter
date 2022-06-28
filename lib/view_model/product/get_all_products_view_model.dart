import 'package:flutter/foundation.dart';
import 'package:qr_code_app/models/API/get_all_product_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/product/product_service.dart';


class GetAllProductsViewModel extends ChangeNotifier {

  GetAllProductModel getAllProductModel = GetAllProductModel();

  getAllProducts() async {
    var result = await ProductService().getAllProducts();

    if (result is Failure) {
      getAllProductModel = GetAllProductModel();
    }

    if (result is Success) {
      getAllProductModel = result.response as GetAllProductModel;
    }

    notifyListeners();
  }
}