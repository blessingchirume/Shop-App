import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/services/notifier_service.dart';

import '../models/order_item.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orders;

  const OrderItem(this.orders);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ${widget.orders.amount}'),
            subtitle: Text(
                DateFormat('dd-mm-yyyy hh:mm').format(widget.orders.dateTime!)),
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
              height: min(widget.orders.products!.length * 20.0 + 50.0, 110.0),
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
                                    child: const Text('Recieve stock'),
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
                  children: widget.orders.products!.map((thisone) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          thisone.title!,
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
