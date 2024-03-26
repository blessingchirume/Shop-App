import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/providers/currency.dart';
import 'package:shop_app/providers/user.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';
import 'package:shop_app/screens/login_page/models/api_user_model.dart';
import 'package:shop_app/screens/login_page/widgets/text_field.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/services/file_conversion_service.dart';
import 'package:shop_app/services/notifier_service.dart';
import 'package:shop_app/widgets/buttons/spinner_button.dart';
import 'widgets/forgot_password.dart';
import 'widgets/login_button.dart';
import 'widgets/logo.dart';
import 'widgets//text_signup.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  static const platform = MethodChannel('com.flutter.epic/test');

  final username = TextEditingController();
  final password = TextEditingController();
  bool passwordObscure = true;
  bool isLoading = false;
  var _login;
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: RepaintBoundary(
              key: key,
              child: Column(
                children: [
                  LogoImage(),
                  TextFieldInput(
                    controller: username,
                    text: "email",
                    iconName: Icons.mail,
                    ltext: "Email",
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.screenWidth! / 20.55,
                        SizeConfig.screenHeight! / 68.3,
                        SizeConfig.screenWidth! / 20.55,
                        SizeConfig.screenHeight! / 34.15),
                    child: TextField(
                      controller: password,
                      obscureText: passwordObscure,
                      style: TextStyle(color: textColor),
                      cursorColor: textColor,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObscure = !passwordObscure;
                              });
                            },
                            icon: Icon(passwordObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: SizeConfig.screenWidth! / 205.5,
                                color: textColor),

                            /// 2
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: texthint),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "password",
                          hintStyle:
                              TextStyle(color: texthint.withOpacity(0.3)),
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: texthint.withOpacity(0.6))),
                    ),
                  ),
                  ForgotPassword(),
                  // AsyncButton(
                  //   label: 'SPINNER BUTTON',
                  //   isLoading: isLoading,
                  //   onPressed: () async => authentication(context),
                  // ),
                  LoginButonColor(
                    onPressed: () {
                      authentication(context);
                    },
                  ),

                  // LoginButonColor(
                  //     onPressed: () async => _generatePrintableInvoice()),
                  // TextSignUp()
                ],
              ),
            ),
          ),
        ));
  }

  void authentication(BuildContext context) async {
    // if (formkey.currentState.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Processing')));
    //   Navigator.pushReplacementNamed(
    //       context, RoutingConstants.bottomNavigation);
    // }
    if (username.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text(
            'Fields Empty',
            textAlign: TextAlign.center,
          )));
    } else {
      ProcessNotificationService.startLoading(context);
      _login =
          await AuthenticationController().auth(username.text, password.text);
      if (!_login) {
        ProcessNotificationService.stopLoading(context);
        ProcessNotificationService.error(context, "failed to login");
        setState(() => isLoading = false);
      } else {
        var provider = Provider.of<UserProvider>(context, listen: false);
        var currencyProvider = Provider.of<Currency>(context, listen: false);
        provider.getUserData();
        currencyProvider.getCurrenciesAsync();
        ProcessNotificationService.stopLoading(context);
        setState(() => isLoading = false);
        Navigator.pushReplacementNamed(context, RoutingConstants.products);
      }
    }
  }

  Future _generatePrintableInvoice() async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();
    // String data = await _serializeTransactionPayload(context, items);
    var data = await FileConversionService()
        .getImageFileFromAssets("main/_avatar.png");
    final String response = await platform.invokeMethod('doPrint', imageBytes);
  }
}
