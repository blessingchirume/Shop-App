
import 'package:flutter/cupertino.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/stock_transfer.dart';

class TransferProvider with ChangeNotifier {
  List<TransferModel> _transfers = [];
  List<TransferModel> get transfers => _transfers;

  Future<void> getPendingTransfers() async {
    _transfers = await BaseController().getPendingTransfers();
    notifyListeners();
  }

  Future<void> confirmTransfer(TransferModel transfer) async {
    await BaseController().confirmTransfer(transfer.toJson());
    this.getPendingTransfers();
    notifyListeners();
  }

  Future<void> rejectTransfer(TransferModel transfer) async {
    await BaseController().rejectTransfer(transfer.toJson());
    this.getPendingTransfers();
    notifyListeners();
  }
}
