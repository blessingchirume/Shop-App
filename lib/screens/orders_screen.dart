import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/stock_transfer.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  List<TransferModel> transfres = [];
  static const String routeName = '/orders';

  Future<void> initializeTransfers() async {
    transfres = await BaseController().getPendingTransfers();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Pending inventory transfers')),
      body: FutureBuilder(
        future: orderData.getAsync(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
          );
        },
      ),
    );
  }
}
