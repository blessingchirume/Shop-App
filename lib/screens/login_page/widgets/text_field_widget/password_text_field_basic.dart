import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';

class TextFieldPasswordBasic extends StatefulWidget {
  final TextEditingController controller;

  const TextFieldPasswordBasic({required this.controller});
  
  @override
  _TextFieldPasswordBasicState createState() => _TextFieldPasswordBasicState();
}

class _TextFieldPasswordBasicState extends State<TextFieldPasswordBasic> {
  bool passwordObscure = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth! / 20.55,
            SizeConfig.screenHeight! / 68.3,
            SizeConfig.screenWidth! / 20.55,
            SizeConfig.screenHeight! / 34.15),
        child: TextField(
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
                icon: Icon(
                    passwordObscure ? Icons.visibility_off : Icons.visibility),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: SizeConfig.screenWidth! / 205.5, color: textColor),

                /// 2
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: texthint),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: "password",
              hintStyle: TextStyle(color: texthint.withOpacity(0.3)),
              labelText: "Password",
              labelStyle: TextStyle(color: texthint.withOpacity(0.6))),
        ),
      ),
    );
  }
}
