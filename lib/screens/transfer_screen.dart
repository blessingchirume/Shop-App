import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/providers/transfer.dart';
import 'package:shop_app/widgets/transfer_item.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class TransferScreen extends StatelessWidget {
  List<TransferModel> transfres = [];
  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransferProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Pendings inventory transfers')),
      body: FutureBuilder(
        future: provider.getPendingTransfers(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: provider.transfers.length,
            itemBuilder: (context, index) => TransferItem(provider.transfers[index]),
          );
        },
      ),
    );
  }
}
