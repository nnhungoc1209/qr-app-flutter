import 'package:flutter/material.dart';
import 'package:qr_code_app/models/API/get_all_departments_model.dart';
import 'package:qr_code_app/models/API/get_all_employee_model.dart';
import 'package:qr_code_app/models/API/get_product_by_qrcode_model.dart';
import 'package:qr_code_app/models/product_model.dart';
import 'package:qr_code_app/shared/app_colors.dart';
import 'package:qr_code_app/view_model/department/get_all_departments_view_model.dart';
import 'package:qr_code_app/view_model/employee/get_all_employees_view_model.dart';
import 'package:qr_code_app/view_model/product/edit_product_view_model.dart';
import 'package:qr_code_app/view_model/product/get_product_by_qrcode.dart';

class GetProductByQrCode extends StatefulWidget {
  final String? qrCode;
  const GetProductByQrCode({Key? key, required this.qrCode}) : super(key: key);

  @override
  State<GetProductByQrCode> createState() => _GetProductByQrCodeState();
}

class _GetProductByQrCodeState extends State<GetProductByQrCode> {
  final List<dynamic> _employeeList = [];
  final List<dynamic> _departmentList = [];

  Product? _editProduct;
  final TextEditingController _txtNameController = TextEditingController();
  final TextEditingController _txtPriceController = TextEditingController();
  final TextEditingController _txtSalePriceController = TextEditingController();
  var _loaiSP;
  final TextEditingController _txtEmployeeController = TextEditingController();
  final TextEditingController _txtCustomerController = TextEditingController();


  var getProductByQrCodeModel = GetProductByQrCodeModel();
  var getAllEmployeesModel = GetAllEmployeeModel();
  var getAllDepartmentsModel = GetAllDepartmentsModel();

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    var getProductByQrCodeViewModel = GetProductByQrCodeViewModel();
    await getProductByQrCodeViewModel.getProductByQrCodes(widget.qrCode ?? '');
    getProductByQrCodeModel = getProductByQrCodeViewModel.getProductByQrCodeModel;

    var getAllEmployeesViewModel = GetAllEmployeesViewModel();
    await getAllEmployeesViewModel.getAllEmployees();
    getAllEmployeesModel = getAllEmployeesViewModel.getAllEmployeeModel;

    var getAllDepartmentsViewModel = GetAllDepartmentsViewModel();
    await getAllDepartmentsViewModel.getAllDepartments();
    getAllDepartmentsModel = getAllDepartmentsViewModel.getAllDepartmentModel;

    setState(() {
      getProductByQrCodeModel.data?.forEach((element) {
        _editProduct = element;
      });

      getAllEmployeesModel.data?.forEach((element) {
        _employeeList.add(element);
      });

      getAllDepartmentsModel.data?.forEach((element) {
        _departmentList.add(element);
      });
    });

    _txtEmployeeController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product Page'),
      ),
      body: Scaffold(
        body: _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getTextFormFieldWidget(_txtNameController, 'Tên hàng hóa', _editProduct?.tenhanghoa ?? '', true),
            const SizedBox(height: 20.0),
            _getTextFormFieldWidget(_txtPriceController, 'Đơn giá', _editProduct?.dongia ?? '', true),
            const SizedBox(height: 20.0),
            _getTextFormFieldWidget(_txtSalePriceController, 'Giá bán', _editProduct?.giaban ?? '', true),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const Text('Khuyến mãi: '),
                  Text(_editProduct?.khuyenmai.toString() == 0 ? 'Không' : 'Có'),
                  const Text('Loại sản phẩm'),
                ],
              ),
            ),
            _getRadioButtonWidget(),
            _getTextFormFieldWidget(_txtEmployeeController, 'Mã nhân viên quét', '', false),
            const SizedBox(height: 20.0),
            //_getTextFormFieldWidget(_txtCustomerController, 'Mã khách hàng', '', false),
            _getComcoBoxWidget(),
            const SizedBox(height: 20.0),
            _getEditButtonWidget()
          ],
        ),
      ),
    );
  }

  Widget _getTextFormFieldWidget(TextEditingController textController, String? lableText, String hintText, bool readOnly) {
    return TextFormField(
      controller: textController,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: lableText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.bluePrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.bluePrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintStyle: const TextStyle(
            fontSize: 15,
            color: AppColors.titleText
        ),
      ),
    );
  }

  Widget _getRadioButtonWidget() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Thùng'),
          leading: Radio<String>(
            value: 'thung',
            groupValue: _loaiSP,
            onChanged: (String? value) {
              setState(() {
                _loaiSP = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Chai'),
          leading: Radio<String>(
            value: 'chai',
            groupValue: _loaiSP,
            onChanged: (String? value) {
              setState(() {
                _loaiSP = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getComcoBoxWidget() {
    List<String> kh = ['Công ty A', 'Công ty B', 'Công ty C'];
    String? _selectedKH = kh[0];
    //String? _selectedKH = 'Chọn khách hàng';
    return (
        DropdownButtonFormField(
          value: _selectedKH,
          onChanged: (String? value) {
            setState(() {
              _selectedKH = value;
            });
          },
          items: kh.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.bluePrimary,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.bluePrimary,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        )
    );
  }

  Widget _getEditButtonWidget() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.width * 0.05,
      ),
      child: ElevatedButton(
          onPressed: _onEditProductPressed,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.07,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.04,
              bottom: MediaQuery.of(context).size.width * 0.04,
            ),
            child: const Text(
              'Edit Product',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
      ),
    );
  }

  Future<void> _onEditProductPressed() async {
    var editProductViewModel = EditProductViewModel();
    int employee = int.parse(_txtEmployeeController.text);
    int customer = int.parse(_txtCustomerController.text);

    await editProductViewModel.editProduct(_editProduct?.productsId, _editProduct?.tenhanghoa ?? '', _editProduct?.dongia ?? '', _editProduct?.giaban ?? '',
        _editProduct?.khuyenmai == 1 ? true : false, _loaiSP, employee, customer);

    if(editProductViewModel.error == ''){
      Navigator.pop(context);
    }
  }
}
