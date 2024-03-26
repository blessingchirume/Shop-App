import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/providers/transfer.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/transfer_item.dart';

class CancellationRequestsScreen extends StatefulWidget {
  const CancellationRequestsScreen({Key? key}) : super(key: key);

  @override
  State<CancellationRequestsScreen> createState() =>
      _CancellationRequestsScreenState();
}

class _CancellationRequestsScreenState
    extends State<CancellationRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<TransferProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Cancellation Requests')),
      body: FutureBuilder(
        future: BaseController().getPendingCancellationRequests(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => ListTile(
              title: Text('\$test'),
              subtitle:
                  Text(DateFormat('dd-mm-yyyy hh:mm').format(DateTime.now())),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    // _expanded = !_expanded;
                  });
                },
                icon: Icon(Icons.expand_more),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_outlined),
        onPressed: () => Navigator.of(context)
            .pushReplacementNamed(RoutingConstants.cancellationRequest),
      ),
    );
  }
}
