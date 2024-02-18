import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/persisted_transaction_model.dart';
import 'package:shop_app/providers/draft_order.dart';
import 'package:shop_app/providers/user.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/dropdown_button.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input.dart';
import 'package:shop_app/screens/login_page/widgets/text_field_widget/text_field_input_with_callback.dart';
import 'package:shop_app/screens/success_page/success_page_view.dart';
import 'package:shop_app/screens/success_page/widgets/lottie_widget.dart';
import 'package:shop_app/services/file_conversion_service.dart';
import 'package:shop_app/services/notifier_service.dart';
import 'package:shop_app/widgets/buttons/spinner_button.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import 'dart:ui' as ui;
import '../models/cart_item.dart' as cartItem;

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';

  static const platform = MethodChannel('com.flutter.epic/test');

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey globalKey = GlobalKey();

  TextEditingController valueTextEditingController = TextEditingController();
  TextEditingController quantityTextEditingController = TextEditingController();
  TextEditingController tenderedAmountTextEditingController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Customer Cart')),
      body: RepaintBoundary(
        key: globalKey,
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total:', style: TextStyle(fontSize: 20.0)),
                    Spacer(),
                    Chip(
                      label: Consumer<Cart>(
                        builder: (context, cart, child) => Text(
                          '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color),
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () async {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            List<String> list = ['USD', 'ECO'];
                            String selectedCurrency = list.first;
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SizedBox(
                                height: 300,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.screenWidth! / 20.55,
                                              SizeConfig.screenHeight! / 68.3,
                                              SizeConfig.screenWidth! / 20.55,
                                              SizeConfig.screenHeight! / 34.15),
                                          child:
                                              DropdownButtonFormField<String>(
                                            onChanged: (value) {
                                              selectedCurrency = value!;
                                            },
                                            value: selectedCurrency,
                                            items: list
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                    Icons.payment_outlined),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  borderSide: BorderSide(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          205.5,
                                                      color: textColor),

                                                  /// 2
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: texthint),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                hintText: "Select currency",
                                                hintStyle: TextStyle(
                                                    color: texthint
                                                        .withOpacity(0.3)),
                                                labelText: "Select currency",
                                                labelStyle: TextStyle(
                                                    color: texthint
                                                        .withOpacity(0.6))),
                                          ),
                                        ),

                                        TextFieldInputWithCallBack(
                                          iconName:
                                              Icons.monetization_on_outlined,
                                          ltext: 'Tendered Amount',
                                          text: 'Tendered Amount',
                                          controller:
                                              tenderedAmountTextEditingController,
                                        ),

                                        // const Text('Modal BottomSheet'),
                                        AsyncButton(
                                          isLoading: isLoading,
                                          label: 'CONFIRM SALE',
                                          onPressed: () async {
                                            await _processTransaction(cart,
                                                selectedCurrency, context);
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
                      child: Text('SALE NOW'),
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
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          var item = cartItem.CartItem(
                              id: cart.items.values.toList()[index].id,
                              title: cart.items.values.toList()[index].title,
                              price: cart.items.values.toList()[index].price,
                              quantity:
                                  cart.items.values.toList()[index].quantity);
                          return _buildEditCartItemDialog(context, item);
                        },
                      )
                    },
                    child: CartItem(
                      productId: cart.items.keys.toList()[index],
                      id: cart.items.values.toList()[index].id,
                      title: cart.items.values.toList()[index].title,
                      price: cart.items.values.toList()[index].price,
                      quantitiy: int.parse(cart.items.values
                          .toList()[index]
                          .quantity!
                          .floor()
                          .toString()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processTransaction(
      Cart cart, String selectedCurrency, BuildContext context) async {
    if (tenderedAmountTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          content: Text(
            'Oops!. Please enter tendered amount',
            textAlign: TextAlign.center,
          ),
        ),
      );
      _generatePrintableInvoice(context, cart.items.values.toList());
      return;
    }

    try {
      List<Map<String, dynamic>> test = [];

      cart.items.forEach((key, value) {
        test.add({
          'ItemCode': value.id,
          // title: value.title,
          'Price': value.price,
          'Quantity': value.quantity
        });
      });

      bool orderplaced = await BaseController().placeOrder({
        'cardCode': 'MS000001',
        'currency': selectedCurrency,
        'total': cart.totalAmount,
        'items': test
      });

      if (orderplaced) {
        _generatePrintableInvoice(context, cart.items.values.toList());
        cart.clear();
        setState(() {
          isLoading = false;
        });
      } else {
        List<Item> draftItems = [];
        cart.items.forEach((key, value) {
          draftItems.add(Item(
              itemCode: value.id!,
              // title: value.title,
              price: value.price,
              quantity: double.parse(value.quantity.toString())));
        });
        var model = PersistedTransactionModel(
            cardCode: 'MS000001',
            currency: selectedCurrency,
            total: cart.totalAmount,
            items: draftItems);
        Provider.of<OfflineOrderProvider>(context, listen: false)
            .appendToSharedPreference(model);
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text(
              'Oops!. Order was not proccessed successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } on SocketException catch (e) {
      List<Item> draftItems = [];
      cart.items.forEach((key, value) {
        draftItems.add(Item(
            itemCode: value.id!,
            // title: value.title,
            price: value.price,
            quantity: double.parse(value.quantity.toString())));
      });
      var model = PersistedTransactionModel(
          cardCode: 'MS000001',
          currency: selectedCurrency,
          total: cart.totalAmount,
          items: draftItems);
      setState(() {
        isLoading = false;
      });
      Provider.of<OfflineOrderProvider>(context, listen: false)
          .appendToSharedPreference(model);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text(
            'Oops!. Order was not proccessed successfully',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Widget _buildEditCartItemDialog(
      BuildContext context, cartItem.CartItem item) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Padding(
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
                          iconName: Icons.production_quantity_limits,
                          ltext: 'Item Quantity',
                          text: 'Item Quantity',
                          controller: quantityTextEditingController,
                        ),

                        TextFieldInputWithCallBack(
                          iconName: Icons.monetization_on_outlined,
                          ltext: 'Sub Total',
                          text: 'Sub Total',
                          controller: valueTextEditingController,
                        ),
                        // TextFieldInput(
                        //   iconName: Icons.monetization_on,
                        //   ltext: 'Sale Value',
                        //   text: 'Sale Value',
                        //   controller: quantityTextEditingController,
                        // ),
                        // const Text('Modal BottomSheet'),
                      ],
                    ),
                  ),
                ),

                // const Text('Modal BottomSheet'),
                ElevatedButton(
                    child: const Text('Update cart items'),
                    onPressed: () {
                      double quantity = item.quantity!;

                      if (valueTextEditingController.text == '' &&
                          quantityTextEditingController.text == '') return;
                      if (quantityTextEditingController.text.isNotEmpty)
                        quantity =
                            double.parse(quantityTextEditingController.text);
                      if (valueTextEditingController.text.isNotEmpty) {
                        var tQuantity =
                            double.parse(valueTextEditingController.text);
                        var tVal = tQuantity / item.price!;
                        quantity = tVal;
                      }

                      try {
                        print(item);
                        cart.updateQuantity(
                            item.id!, item.title!, item.price!, quantity);
                        quantityTextEditingController.text = '';
                        valueTextEditingController.text = '';
                        setState(() {});
                        Navigator.pop(context);
                      } catch (e) {
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _generatePrintableInvoice(
      BuildContext context, List<cartItem.CartItem> items) async {
    // String data = await _serializeTransactionPayload(context, items);
    var data = await FileConversionService().readCounter();
    final String response =
        await CartScreen.platform.invokeMethod('doPrint', data);
  }

  Future<String> _serializeTransactionPayload(
      BuildContext context, List<cartItem.CartItem> items) async {
    var provider = Provider.of<UserProvider>(context, listen: false);
    List<Map<String, dynamic>> test = [];

    items.forEach((element) {
      test.add({
        'name': element.title,
        // title: value.title,
        'rate': element.price,
        'hours': element.quantity
      });
    });
    var xxx = jsonEncode({
      "number": 1,
      "date": DateTime.now().toString(),
      "dueDate": DateTime.now().toString(),
      "userName": provider.user.user!.name.toString(),
      "userLocation":
          provider.user.user!.branch!.warehouseDescription.toString(),
      "userEmail": provider.user.user!.email.toString(),
      "client": {
        "name": "Cash customer",
        "address": "Cash customer address",
        "email": "cash-customer@gmail.com"
      },
      "items": test
    });
    // final String response = await rootBundle.loadString('assets/data/en.json');
    // final data = await json.decode(response);
    return xxx;
  }
}
