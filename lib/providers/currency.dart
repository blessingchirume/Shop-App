import 'package:flutter/cupertino.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/currency_model.dart';

class Currency with ChangeNotifier {
  List<CurrencyModel> _currencies = [];

  List<CurrencyModel> get currencies => _currencies;

  late CurrencyModel _selectedCurrency;

  CurrencyModel get selectedCurrency => _selectedCurrency;

  Future<void> getCurrenciesAsync() async {
    var data = await BaseController().getCurrencies();
    if (_currencies.isEmpty) {
      for (var element in data) {
        _currencies.add(new CurrencyModel.fromJson(element));
      }
      notifyListeners();
    }
  }

  Future<void> selectCurrency(CurrencyModel currency) async {
    _selectedCurrency = currency;
    notifyListeners();
  }
}
