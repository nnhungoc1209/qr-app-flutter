import 'package:flutter/material.dart';
import 'package:qr_code_app/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewProductDetailPage extends StatefulWidget {
  final Product product;

  const ViewProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ViewProductDetailPage> createState() => _ViewProductDetailPageState();
}

class _ViewProductDetailPageState extends State<ViewProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Product Detail'),
      ),
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              QrImage(
                data: widget.product.maqr ?? '',
                size: 230,
                backgroundColor: Colors.white,
                version: QrVersions.auto,
              ),
              _getTextWidget('ID hàng hóa: ' + widget.product.productsId.toString()),
              _getTextWidget('Tên hàng hóa: ' + widget.product.tenhanghoa.toString()),
              _getTextWidget('Đơn giá : ' + widget.product.dongia.toString()),
              _getTextWidget('Giá bán : ' + widget.product.giaban.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextWidget(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 18.0,
        height: 1.5
      ),
    );
  }
}
