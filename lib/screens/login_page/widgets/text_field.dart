import 'package:flutter/material.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_password.dart';

class LoginTextField extends StatefulWidget {

  final TextEditingController username;

    final TextEditingController password;


  const LoginTextField({ required this.username, required this.password});

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          TextFieldInput(
            controller: widget.username,
            text: "email",
            iconName: Icons.mail,
            ltext: "Email",
          ),
          TextFieldPassword(controller: widget.password,),
        ]));
  }
}
