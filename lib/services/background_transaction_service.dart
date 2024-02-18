import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/persisted_transaction_model.dart';

class BackgroundTransactionService {
  // static final BackgroundTransactionService _backgroundTransactionService =
  //     BackgroundTransactionService._internal();

  void createTransaction() async {
    List<PersistedTransactionModel> transactions =
        await this.retrieveFromSharedPreference();

    if (transactions.isNotEmpty) {
      var response = await BaseController().placeOrder(transactions.first.toJson());

      if (response != 200) return;

      transactions.remove(transactions.first);

      await overrideSharedPreference(transactions);

      print("task result: ${response}");
    }
  }

  Future<List<PersistedTransactionModel>> retrieveFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<PersistedTransactionModel> transactions = [];
    // prefs.remove('offline_orders');
    if (!prefs.containsKey("offline_orders")) return [];
    String response = await prefs.getString('offline_orders');
    List<dynamic> list = jsonDecode(response);
    if (list.isNotEmpty) {
      list.forEach((element) {
        transactions.add(PersistedTransactionModel.fromJson(element));
      });
    }

    return transactions;
  }

  Future<void> overrideSharedPreference(
      List<PersistedTransactionModel> transactions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('offline_orders');
    await prefs.setString('offline_orders', jsonEncode(transactions));
  }
}
