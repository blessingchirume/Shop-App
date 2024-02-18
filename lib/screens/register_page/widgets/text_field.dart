import 'package:flutter/material.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_password.dart';

class RegisterTextField extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  const RegisterTextField(
      {Key? key,
      required this.email,
      required this.username,
      required this.password,
      required this.confirmPassword})
      : super(key: key);

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          TextFieldInput(
              controller: widget.username,
              text: "username",
              iconName: Icons.account_circle,
              ltext: "User Name"),
          TextFieldInput(
            controller: widget.email,
            text: "email",
            iconName: Icons.mail,
            ltext: "Email",
          ),
          TextFieldPassword(
            controller: widget.password,
          ),
          TextFieldPassword(
            controller: widget.confirmPassword,
          ),
        ]));
  }
}
