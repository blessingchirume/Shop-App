import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/services/notifier_service.dart';

import '../models/persisted_transaction_model.dart';

class DraftItem extends StatefulWidget {
  final PersistedTransactionModel order;

  const DraftItem(this.order);

  @override
  _DraftItemState createState() => _DraftItemState();
}

class _DraftItemState extends State<DraftItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ${widget.order.total}'),
            subtitle: Text(DateTime.now().toString()),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.items!.length * 20.0 + 50.0, 110.0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    context: context,
                    builder: (BuildContext ctx) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SizedBox(
                          height: 300,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('ADD TO CART'),
                                    onPressed: () {
                                      ProcessNotificationService.startLoading(
                                          context);

                                      try {
                                        // BaseController().confirmTransfer();

                                        Navigator.pop(context);
                                        ProcessNotificationService.stopLoading(
                                            context);
                                      } catch (e) {
                                        ProcessNotificationService.stopLoading(
                                            context);
                                        ProcessNotificationService.error(
                                            context, "Oops: ${e}");
                                        Navigator.pop(context);
                                      }
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
                child: ListView(
                  children: widget.order.items!.map((thisone) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          thisone.itemCode!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${thisone.quantity} x \$ ${thisone.price}'),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
