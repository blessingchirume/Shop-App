import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/success_page/widgets/lottie_widget.dart';
import 'package:shop_app/screens/success_page/widgets/ok_button.dart';
import 'package:shop_app/screens/success_page/widgets/router_text.dart';

class CheckCart extends StatelessWidget {
  final String message;
  final Function() callback;
  const CheckCart({Key? key, required this.message, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        LottieWidget(),
        RouterText(
          message: message,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! / 68.3,
        ),
        OkButton(callBack: callback,),
      ]),
    );
  }
}
