import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';

import '../models/order_item.dart';
import '../models/cart_item.dart' as ci;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(List<ci.CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
    notifyListeners();
  }

  Future<void> getAsync() async {
    var data = await BaseController().transfers();
    _orders = [];
    if (_orders.isEmpty) {
      for (var element in data) {
        _orders.add(new OrderItem(
            id: element['JournalMemo'],
            amount: 100.0,
            dateTime: DateTime.now(),
            products: [
              ci.CartItem(
                  id: element['StockTransferLines'][0]['ItemCode'],
                  title: element['StockTransferLines'][0]['WarehouseCode'],
                  quantity: double.parse(element['StockTransferLines'][0]['Quantity']),
                  price: double.parse(element['StockTransferLines'][0]['Price'])),
            ]));
      }
      notifyListeners();
    }
  }
}
