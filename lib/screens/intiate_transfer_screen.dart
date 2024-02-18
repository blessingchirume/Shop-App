import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart';

class InitiateTransferSreen extends StatelessWidget {
  final TextEditingController brachTextEditingController =
      TextEditingController();
  final TextEditingController quantityTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Transfers')),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Initiate Transfer'),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // _testKotlinMethod();
                      // Provider.of<Orders>(context, listen: false).addOrder(
                      //   cart.items.values.toList(),
                      //   cart.totalAmount,
                      // );

                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 300,
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFieldInput(
                                        iconName:
                                            Icons.currency_bitcoin_outlined,
                                        ltext: 'Destination Branch',
                                        text: 'Destination Branch',
                                        controller: brachTextEditingController,
                                      ),
                                      TextFieldInput(
                                        iconName:
                                            Icons.currency_bitcoin_outlined,
                                        ltext: 'Quantity',
                                        text: 'Quantity',
                                        controller:
                                            quantityTextEditingController,
                                      ),
                                      // const Text('Modal BottomSheet'),
                                      ElevatedButton(
                                        child: const Text('Initiate Transfer'),
                                        onPressed: () {
                                          Map<String, dynamic> data =
                                              Map<String, dynamic>();

                                          data['Quantity'] =
                                              quantityTextEditingController
                                                  .text;
                                          data['WarehouseCode'] =
                                              brachTextEditingController.text;
                                          BaseController()
                                              .initiateTransfer(data);
                                          // cart.clear();

                                          // _testKotlinMethod();

                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('TRANSFER NOW'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, child) => ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) => CartItem(
                  productId: cart.items.keys.toList()[index],
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  price: cart.items.values.toList()[index].price,
                  quantitiy: cart.items.values.toList()[index].quantity!.toInt(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
