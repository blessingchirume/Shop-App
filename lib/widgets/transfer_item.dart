import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/providers/transfer.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/transfers/reject_transfer_screen.dart';
import 'package:shop_app/services/notifier_service.dart';

import '../models/order_item.dart' as ord;

class TransferItem extends StatefulWidget {
  final TransferModel transfer;

  const TransferItem(this.transfer);

  @override
  _TransferItemState createState() => _TransferItemState();
}

class _TransferItemState extends State<TransferItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransferProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.transfer.journalMemo}'),
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
              height: min(
                  widget.transfer.stockTransferLines!.length * 20.0 + 50.0,
                  110.0),
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
                                    child: const Text('RECIEVE STOCK'),
                                    onPressed: () {
                                      ProcessNotificationService.startLoading(
                                          context);

                                      try {
                                        provider
                                            .confirmTransfer(widget.transfer);

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
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(
                                              SizeConfig.screenWidth! / 1.37,
                                              SizeConfig.screenHeight! /
                                                  13.66)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.redAccent),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child:
                                        const Text('REJECT INCOMING TRANSER'),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransferRejectionScreen(
                                          transfer: widget.transfer,
                                        ),
                                      ),
                                    ),
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
                  children: widget.transfer.stockTransferLines!.map((thisone) {
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
