import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/persisted_transaction_model.dart';

class OfflineOrderProvider with ChangeNotifier {
  List<PersistedTransactionModel> _orders = [];

  List<PersistedTransactionModel> get orders => _orders;

  void writeToSharedPreference(List<PersistedTransactionModel> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('offline_orders', jsonEncode(list));
  }

  Future<void> retrieveFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('offline_orders');
    if (!prefs.containsKey("offline_orders")) return;
    String response = await prefs.getString('offline_orders');
    List<dynamic> list = jsonDecode(response);
    if (list.isNotEmpty) {
      list.forEach((element) {
        _orders.add(PersistedTransactionModel.fromJson(element));
      });
    }

    notifyListeners();
  }

  Future<void> appendToSharedPreference(PersistedTransactionModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('offline_orders');
    if (!prefs.containsKey("offline_orders"))
      prefs.setString('offline_orders', jsonEncode([]));
    String response = await prefs.getString('offline_orders');
    List<dynamic> list = jsonDecode(response);
    if (list.isNotEmpty) {
      list.forEach((element) {
        _orders.add(PersistedTransactionModel.fromJson(element));
      });
    }

    list.add(model);

    prefs.setString('offline_orders', jsonEncode(list));

    notifyListeners();
  }
}
