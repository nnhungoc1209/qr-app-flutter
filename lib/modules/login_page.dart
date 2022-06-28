import 'package:flutter/material.dart';
import 'package:qr_code_app/modules/view_products_page.dart';
import 'package:qr_code_app/shared/app_colors.dart';
import 'package:qr_code_app/view_model/auth/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? errorUsernameText = '';
  String? errorPasswordText = '';

  final TextEditingController _txtUsernameCtrl = TextEditingController();
  final TextEditingController _txtPasswordCtrl = TextEditingController();

  @override

  void initState() {
    super.initState();

    errorUsernameText = null;
    errorPasswordText = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentLoginWidget(),
    );
  }

  Widget _contentLoginWidget() {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: screenHeight * .02,
          right: screenHeight * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getWelcomeWidget(),
            SizedBox(height: screenHeight * .07),
            _getUsernameWidget(),
            SizedBox(height: screenHeight * .04),
            _getPasswordWidget(),
            SizedBox(height: screenHeight * .04),
            _getLoginButtonWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getWelcomeWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 120.0),
      child: const Text.rich(
          TextSpan(
              children:<TextSpan>[
                TextSpan(
                  text: 'Welcome, ',
                  style: TextStyle(
                    color: AppColors.bluePrimary,
                    fontFamily: 'Sans-serif',
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                    text: '\nSign in to continue!',
                    style: TextStyle(
                      color: AppColors.blue1,
                      fontFamily: 'Sans-serif',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    )
                )
              ]
          )
      ),
    );
  }

  Widget _getUsernameWidget() {
    return TextField(
      controller: _txtUsernameCtrl,
      decoration: InputDecoration(
          label: const Text('Username'),
          errorText: errorUsernameText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )
      ),
    );
  }

  Widget _getPasswordWidget() {
    return TextField(
      controller: _txtPasswordCtrl,
      obscureText: true,
      decoration: InputDecoration(
          label: const Text('Password'),
          errorText: errorPasswordText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          )
      ),
    );
  }

  Widget _getLoginButtonWidget() {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onLoginPressed,
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 18.0
          ),
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
            primary: AppColors.bluePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
      ),
    );
  }

  bool validate() {

    bool isValid = true;

    if(_txtUsernameCtrl.text.isEmpty){
      setState(() {
        errorUsernameText = 'Username is required!';
      });
      isValid = false;
    }

    if(_txtPasswordCtrl.text.isEmpty){
      setState(() {
        errorPasswordText = 'Password is required!';
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> _onLoginPressed() async {
    var loginViewModel = LoginViewModel();
    String username = _txtUsernameCtrl.text;
    String password = _txtPasswordCtrl.text;

    if (validate()) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const ViewProductsPage(),
      //     )
      // );

      await loginViewModel.login(username, password);
      //int? departmentId = loginViewModel.loginModel.user?.departmentId;
      if (loginViewModel.error == '') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewProductsPage(),
            )
        );
      } else {
        setState(() {
          errorUsernameText = 'Incorrect username or password';
        });
        setState(() {
          errorPasswordText = 'Incorrect username or password';
        });
      }
    }
  }
}
