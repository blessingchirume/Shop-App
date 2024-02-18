import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';

class TextFieldInputWithCallBack extends StatefulWidget {
  final String text;
  final IconData iconName;
  final String ltext;
  final TextEditingController controller;
  TextFieldInputWithCallBack(
      {required this.text,
      required this.iconName,
      required this.ltext,
      required this.controller,
      
      });

  @override
  State<TextFieldInputWithCallBack> createState() => _TextFieldInputWithCallBackState();
}

class _TextFieldInputWithCallBackState extends State<TextFieldInputWithCallBack> {
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
          keyboardType: TextInputType.number,
          controller: widget.controller,
          style: TextStyle(color: textColor),
          cursorColor: textColor,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.iconName),
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
              hintText: widget.text,
              hintStyle: TextStyle(color: texthint.withOpacity(0.3)),
              labelText: widget.ltext,
              labelStyle: TextStyle(color: texthint.withOpacity(0.6))),
        ),
      ),
    );
  }
}
