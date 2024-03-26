import 'dart:typed_data';

import 'package:davinci/davinci.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/login_page/models/api_user_model.dart';
import 'package:shop_app/screens/ticket.dart';
import 'package:shop_app/services/file_conversion_service.dart';
import 'package:ticket_widget/ticket_widget.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ///1.create a globalkey variable
  GlobalKey imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///2. wrap the desired widget with Davinci widget
            Davinci(
              builder: (key) {
                ///3. set the widget key to the globalkey
                imageKey = key;
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: TextButton(
                onPressed: () async {
                  ///4. pass the globalKey varible to DavinciCapture.click.
                  await DavinciCapture.click(imageKey);
                },
                child: Text('capture',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            TextButton(
              onPressed: () async {
                final cart = Provider.of<Cart>(context, listen: false);

                ///If the widget was not in the widget tree
                ///pass the widget that has to be converted into image.
                // var image = await DavinciCapture.offStage(
                //     PreviewWidget(
                //       cart: new Cart(),
                //     ),
                //     returnImageUint8List: true,
                //     openFilePreview: false,
                //     pixelRatio: MediaQuery.of(context).devicePixelRatio);
                // // await DavinciCapture.offStage(PreviewWidget(),);

                // var xyz = image;

                // _generatePrintableInvoice(
                //     context, cart.items.values.toList(), image);
              },
              child: Text('Capture'),
            )
          ],
        ),
      ),
    );
  }

  Future _generatePrintableInvoice(
      BuildContext context, List<CartItem> items, Uint8List image) async {
    // String data = await _serializeTransactionPayload(context, items);
    var data = await FileConversionService().readCounter();
    final String response =
        await CartScreen.platform.invokeMethod('doPrint', image);
  }
}

/// This widget is not mounted when the App is mounted.
class PreviewWidget extends StatelessWidget {
  final Cart cart;
  final int invoiceNumber;
  final User? user;
  final double tenderedAmount;

  const PreviewWidget(
      {Key? key,
      required this.cart,
      required this.invoiceNumber,
      required this.user,
      required this.tenderedAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      width: 58 * 6.299,
      height: 116 * 6.299,
      isCornerRounded: true,
      padding: EdgeInsets.all(20),
      child: TicketData(
        cart: cart,
        invoiceNumber: invoiceNumber,
        tenderedAmount: tenderedAmount,
        user: user,
      ),
    );
  }
}
