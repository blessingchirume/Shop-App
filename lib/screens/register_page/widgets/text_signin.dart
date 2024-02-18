import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/login_page/login_page_view.dart';
import 'package:shop_app/screens/success_page/success_page_view.dart';

class TextSignIn extends StatelessWidget {
  final String message;
  final Function() callback;
  TextSignIn({required this.message, required this.callback});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth! / 20.55, 0,
          SizeConfig.screenWidth! / 20.55, 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(color: texthint),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckCart(
                              message: "test message",
                              callback: this.callback,
                            )));
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.screenHeight! / 45.54

                    /// 15.0
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
