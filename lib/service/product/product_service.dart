import 'package:dio/dio.dart';
import 'package:qr_code_app/models/API/delete_product_model.dart';
import 'package:qr_code_app/models/API/edit_product_model.dart';
import 'package:qr_code_app/models/API/get_all_product_model.dart';
import 'package:qr_code_app/models/API/get_product_by_qrcode_model.dart';
import 'package:qr_code_app/service/api_status.dart';

class ProductService {
  Future<Object> getAllProducts() async {
    var getAllProductsModel = GetAllProductModel();
    try {
      Dio dio = Dio();
      var response = await dio.get('http://192.168.1.14:8000/api/products');
      print(response.toString());

      if(response.data != null && response.statusCode == 200) {
        getAllProductsModel = GetAllProductModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: getAllProductsModel
      );
    }
    on DioError catch (e) {
      return Failure(
          code: e.response?.statusCode,
          errorResponse: e.toString()
      );
    }
  }

  Future<Object> getProductByQrCode(String qrcode) async {
    var getProductByQrCodeModel = GetProductByQrCodeModel();
    try {
      Dio dio = Dio();
      var response = await dio.get('http://192.168.1.14:8000/api/products/' + qrcode + '/qrcode');
      print(response.toString());

      if(response.data != null && response.statusCode == 200) {
        getProductByQrCodeModel = GetProductByQrCodeModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: getProductByQrCodeModel
      );
    }
    on DioError catch (e) {
      return Failure(
          code: e.response?.statusCode,
          errorResponse: e.toString()
      );
    }
  }

  Future<Object> editProduct(int? id, String tenhanghoa, String dongia, String giaban,
      bool khuyenmai, String loaihanghoa, int nvquet, int idkhachhang) async {
    var editProductModel = EditProductModel();

    FormData formData = FormData.fromMap({
      'tenhanghoa': tenhanghoa,
      'dongia': dongia,
      'giaban': giaban,
      'khuyenmai': khuyenmai ? 1 : 0,
      'loaihanghoa': loaihanghoa,
      'ngayquet': DateTime.now(),
      "toadox": null,
      "toadoy": null,
      "employees_id": nvquet,
      "customers_id": idkhachhang
    });

    try {
      Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.post('http://192.168.1.14:8000/api/products/' + id.toString() + '?_method=PUT',
          data: formData);
      print(response);
      print(response.statusCode);

      if(response.data != null && response.statusCode == 200) {
        print('Đã sửa thành công Product');
        editProductModel = EditProductModel.fromJson(response.data);
      }

      return Success(
        code: response.statusCode,
        response: editProductModel,
      );
    }
    on DioError catch (e) {
      print('Exception:' + e.response.toString());
      return Failure(
          code: e.response?.statusCode,
          errorResponse: e.toString()
      );
    }
  }

  Future<Object> deleteProduct(int id) async {
    var deleteProductModel = DeleteProductModel();
    try {
      Dio dio = Dio();
      var response = await dio.delete('http://192.168.1.14:8000/api/products/' + id.toString());

      if(response.data != null && response.statusCode == 200) {
        print('Đã xóa thành công product ' + id.toString());
        deleteProductModel = DeleteProductModel.fromJson(response.data);
      }

      return Success(
          code: response.statusCode,
          response: deleteProductModel
      );
    }
    on DioError catch (e) {
      return Failure(
          code: e.response?.statusCode,
          errorResponse: e.toString()
      );
    }
  }
}
