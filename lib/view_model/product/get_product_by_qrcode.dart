import 'package:flutter/foundation.dart';
import 'package:qr_code_app/models/API/get_product_by_qrcode_model.dart';
import 'package:qr_code_app/service/api_status.dart';
import 'package:qr_code_app/service/product/product_service.dart';


class GetProductByQrCodeViewModel extends ChangeNotifier {

  GetProductByQrCodeModel getProductByQrCodeModel = GetProductByQrCodeModel();

  getProductByQrCodes(String qrcode) async {
    var result = await ProductService().getProductByQrCode(qrcode);

    if (result is Failure) {
      getProductByQrCodeModel = GetProductByQrCodeModel();
    }

    if (result is Success) {
      getProductByQrCodeModel = result.response as GetProductByQrCodeModel;
    }

    notifyListeners();
  }
}