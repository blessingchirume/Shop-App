import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';

class OkButton extends StatefulWidget {
  final Function() callBack;
  const OkButton({Key? key, required this.callBack}) : super(key: key);

  @override
  _OkButtonState createState() => _OkButtonState();
}

class _OkButtonState extends State<OkButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callBack,
      child: Container(
          width: SizeConfig.screenWidth! / 2,

          /// 200
          height: SizeConfig.screenHeight! / 12.42,

          /// 55
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Text(
            "OK",
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.screenHeight! / 37.95),
          ))

          /// 18
          ),
    );
  }
}
