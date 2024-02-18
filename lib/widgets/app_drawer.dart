import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/providers/user.dart';
import 'package:shop_app/screens/login_page/models/api_user_model.dart';

import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  late ApiUserModel user = ApiUserModel();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${user.user.user!.name}!!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Transfers'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RoutingConstants.transfers);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit_attributes_outlined),
            title: Text('Drafts'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RoutingConstants.draftSales);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(RoutingConstants.profile);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text('Manage Products'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(UserProductsScreen.routeName);
          //   },
          // ),
        ],
      ),
    );
  }
}
