import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_app/models/API/get_all_product_model.dart';
import 'package:qr_code_app/models/product_model.dart';
import 'package:qr_code_app/modules/ScanQrPage.dart';
import 'package:qr_code_app/modules/view_product_detail_page.dart';
import 'package:qr_code_app/shared/app_colors.dart';
import 'package:qr_code_app/shared/delete_alert.dart';
import 'package:qr_code_app/view_model/product/delete_product_view_model.dart';
import 'package:qr_code_app/view_model/product/get_all_products_view_model.dart';

class ViewProductsPage extends StatefulWidget {
  const ViewProductsPage({Key? key}) : super(key: key);

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  var getAllProductsModel = GetAllProductModel();

  final List<Product> _productList = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    var getAllProductsViewModel = GetAllProductsViewModel();
    await getAllProductsViewModel.getAllProducts();

    getAllProductsModel = getAllProductsViewModel.getAllProductModel;

    setState(() {
      getAllProductsModel.data?.forEach((element) {
        _productList.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: _getListProduct(),
    );
  }

  Widget _getListProduct() {
    return ListView.builder(
      itemCount: _productList.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                padding: const EdgeInsets.all(2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                onPressed: (_) async {
                  PermissionStatus status = await _getCameraPermission();
                  if (status.isGranted) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanQrPage()));
                  }
                },
                backgroundColor: AppColors.titleText,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (_) => _showDeleteAlert(_productList[index].productsId ?? 0),
                backgroundColor: AppColors.red,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewProductDetailPage(product: _productList[index]),
              )
              )
            },
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: ListTile(
                title: Text(_productList[index].tenhanghoa ?? '',),
              ),
            ),
          ),
        ) ;
      }
    );
  }

  _showDeleteAlert(int id) {
    CustomDeleteAlert().deleteAlert(
      context: context,
      item: 'product',
      cancelFunction: () {
        Navigator.pop(context);
      },
      yesFunction: () => _onDeleteProductPressed(id));
  }

  Future<void> _onDeleteProductPressed(int id) async {
    Navigator.pop(context);
    var deleteProductViewModel = DeleteProductViewModel();
    await deleteProductViewModel.deleteProduct(id);
    setState(() {
      _productList.removeWhere((product) => product.productsId == id);
    });
  }

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }
}
