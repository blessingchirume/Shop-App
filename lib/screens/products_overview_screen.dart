import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/models/currency_model.dart';
import 'package:shop_app/providers/currency.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  bool _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          Consumer<Currency>(
            builder: (context, value, child) {
              return PopupMenuButton(
                icon: Icon(Icons.currency_exchange_outlined),
                onSelected: (CurrencyModel selectedItem) async {
                  // await value.selectCurrency(selectedItem);
                  await productProvider
                      .refreshProductsFromSharedPreferencesWitheRate(
                          selectedItem.rate!);
                },
                itemBuilder: (context) => value.currencies
                    .map(
                      (e) => PopupMenuItem(
                        child: Text(e.code!),
                        value: e,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (selectedItems) {
              setState(() {
                if (selectedItems == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Badge(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                value: cart.itemCount.toString(),
              );
            },
          ),
        ],
      ),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
