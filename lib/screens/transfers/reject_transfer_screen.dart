import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/providers/transfer.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input_with_callback.dart';
import 'package:shop_app/screens/success_page/widgets/lottie_widget.dart';
import 'package:shop_app/services/notifier_service.dart';

class TransferRejectionScreen extends StatelessWidget {
  final TransferModel transfer;
  const TransferRejectionScreen({Key? key, required this.transfer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quantityTextEditingController;
    var valueTextEditingController;

    var provider = Provider.of<TransferProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: SizeConfig.screenHeight!,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LottieWidget(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.screenWidth! / 20.55,
                        SizeConfig.screenHeight! / 68.3,
                        SizeConfig.screenWidth! / 20.55,
                        SizeConfig.screenHeight! / 34.15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          
                          TextFieldInputWithCallBack(
                            iconName: Icons.monetization_on_outlined,
                            ltext: 'Rejection reason',
                            text: 'Rejection reason',
                            controller: valueTextEditingController,
                          ),
                        ],
                      ),
                    ),
                  ),
    
                  // const Text('Modal BottomSheet'),
                  ElevatedButton(
                      child: const Text('REJECT TRANSFER'),
                      onPressed: () {
                        ProcessNotificationService.startLoading(context);
    
                        try {
                          provider.rejectTransfer(this.transfer);
                          // Navigator.pop(context);
                          ProcessNotificationService.stopLoading(context);
                        } catch (e) {
                          ProcessNotificationService.stopLoading(context);
                          ProcessNotificationService.error(context, "Oops: ${e}");
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
