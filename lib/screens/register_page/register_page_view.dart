import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_password.dart';
import 'package:shop_app/screens/register_page/widgets/background_image.dart';
import 'package:shop_app/screens/register_page/widgets/text_signin.dart';
import 'package:shop_app/services/notifier_service.dart';

import 'widgets/register_button.dart';
import 'widgets/text_field.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  _RegisterPageViewState createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var _register;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackgroundImage(),
                TextFieldInput(
                    controller: username,
                    text: "username",
                    iconName: Icons.account_circle,
                    ltext: "User Name"),
                TextFieldInput(
                  controller: email,
                  text: "email",
                  iconName: Icons.mail,
                  ltext: "Email",
                ),
                TextFieldPassword(
                  controller: password,
                ),
                TextFieldPassword(
                  controller: confirmPassword,
                ),
                RegisterButton(
                  onPressed: () async {
                    // if (formkey.currentState.validate()) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Processing')));
                    //   Navigator.pushReplacementNamed(
                    //       context, RoutingConstants.bottomNavigation);
                    // }
                    log(password.text);
                    if (username.text.isEmpty ||
                        password.text.isEmpty ||
                        email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          content: Text(
                            'Fields Emptyz',
                            textAlign: TextAlign.center,
                          )));
                    } else {
                      ProcessNotificationService.startLoading(context);

                      _register = await AuthenticationController()
                          .register(username.text, email.text, password.text);

                      if (!_register) {
                        ProcessNotificationService.stopLoading(context);
                        ProcessNotificationService.error(
                            context, "failed to logins");
                      } else {
                        ProcessNotificationService.stopLoading(context);
                        // await loading shops from this point
                        // get a list of shops
                        // load all data relavant
                        // proceed

                        // showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (BuildContext context) => const Padding(
                        //     padding: EdgeInsets.all(8.0),
                        //     child: ShopDropdownWidget(isVolume: true),
                        //   ),
                        // );

                        Navigator.pushReplacementNamed(
                            context, RoutingConstants.login);
                      }
                    }
                  },
                ),
                TextSignIn(
                  callback: () {},
                  message:
                      'Your request has been submitted\n You will be notified once your account \n has been created',
                )
              ],
            ),
          ),
        ));
  }
}
