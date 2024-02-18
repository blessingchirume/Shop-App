import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/persisted_transaction_model.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/providers/draft_order.dart';
import 'package:shop_app/widgets/draft_item.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class DraftOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OfflineOrderProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Draft Sales')),
      body: FutureBuilder(
        future: orderData.retrieveFromSharedPreference(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (context, index) => DraftItem(orderData.orders[index]),
          );
        },
      ),
    );
  }
}
