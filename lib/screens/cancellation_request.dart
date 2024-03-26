import 'package:flutter/material.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input_with_callback.dart';
import 'package:shop_app/screens/success_page/widgets/lottie_widget.dart';
import 'package:shop_app/services/notifier_service.dart';

class CancellationRequestSCreen extends StatelessWidget {
  CancellationRequestSCreen({Key? key}) : super(key: key);
  final TextEditingController invoiceNumberTextEditingController =
      TextEditingController();
  final TextEditingController cancellationReasonTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                              iconName: Icons.receipt_long_outlined,
                              ltext: 'Invoice Number',
                              text: 'Invoice Number',
                              controller: invoiceNumberTextEditingController,
                            ),
                            TextFieldInput(
                              iconName: Icons.info_outline,
                              ltext: 'Rejection Reason',
                              text: 'Rejection Reason',
                              controller:
                                  cancellationReasonTextEditingController,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // const Text('Modal BottomSheet'),
                    ElevatedButton(
                        child: const Text('REQUEST CANCELLATION'),
                        onPressed: () {
                          ProcessNotificationService.startLoading(context);

                          try {
                            BaseController().sendorderCancellationRequest({
                              'invoice_number':
                                  invoiceNumberTextEditingController.text,
                              'reason':
                                  cancellationReasonTextEditingController.text
                            });
                            // Navigator.pop(context);
                            ProcessNotificationService.stopLoading(context);
                          } catch (e) {
                            ProcessNotificationService.stopLoading(context);
                            ProcessNotificationService.error(
                                context, "Oops: ${e}");
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
