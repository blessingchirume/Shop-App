import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'login_page/models/api_user_model.dart';

class MyTicketView extends StatelessWidget {
  const MyTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: TicketWidget(
          width: 350,
          height: 500,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: Placeholder()
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  final Cart cart;
  final int invoiceNumber;
  final double tenderedAmount;
  final User? user;
  const TicketData({
    Key? key,
    required this.cart,
    required this.invoiceNumber,
    required this.tenderedAmount,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<UserProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120.0,
                height: 25.0,
              ),
            ],
          ),
          Center(
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Quality Gases',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Invoice Number",
                    style: const TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "${this.invoiceNumber}",
                      style: const TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w100),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ticketDetailsWidget(
                    'Sales Personel', '${user!.name}', 'Date', '${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())}'),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: _buildItemRow('QTY item', 'price'),
                ),
                Column(
                  children: cart.items.values
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: _buildItemRow(
                                '${item.quantity}x ${item.title}',
                                '${item.price}'),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: _buildItemRow('Sale Total', '${cart.totalAmount}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: _buildItemRow('Tendered Amount', 'Change'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: _buildItemRow(
                      '${tenderedAmount}',
                      (tenderedAmount -
                              (double.parse(cart.totalAmount.toString())))
                          .toString()),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40.0, left: 75.0, right: 75.0),
            child: Center(
              child: Text(
                'Thank you!',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // const Text('         Developer: instagram.com/DholaSain')
        ],
      ),
    );
  }

  Widget _buildItemRow(
    String firstTitle,
    String firstDesc,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                firstTitle,
                style: const TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                firstDesc,
                style: const TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ],
        )
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
