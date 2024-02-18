import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/size_config.dart';

class RouterText extends StatelessWidget {
  final String message;
  const RouterText({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.screenHeight! / 85.38,
          bottom: SizeConfig.screenHeight! / 85.38),

      /// 8.0-8.0
      child: Text(this.message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black54,
              fontSize: SizeConfig.screenHeight! / 35.32)),

      /// 25
    );
  }
}
