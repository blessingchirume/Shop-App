import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';

import 'product.dart';

class Products with ChangeNotifier {
  // List<Product> _items = [
  //   Product(
  //     id: 'p2',
  //     title: 'Commecial LP Gas',
  //     description: 'Commercial LP Gas for industrial use',
  //     price: 59.99,
  //     imageUrl:
  //         'https://scontent.fhre2-2.fna.fbcdn.net/v/t39.30808-6/307273770_1539631713168461_6747591523823271969_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=dd5e9f&_nc_ohc=ZA3snlQFR0cAX-Aleez&_nc_ht=scontent.fhre2-2.fna&oh=00_AfB3PC2QlNMSC4tKwpsj0hnitVmmz-VTDZNQV9wzmK-P7A&oe=65C22662',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'Residential LP Gas',
  //     description: 'Commercial LP Gas for industrial use',
  //     price: 49.99,
  //     imageUrl:
  //         'https://scontent.fhre2-2.fna.fbcdn.net/v/t39.30808-6/307273770_1539631713168461_6747591523823271969_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=dd5e9f&_nc_ohc=ZA3snlQFR0cAX-Aleez&_nc_ht=scontent.fhre2-2.fna&oh=00_AfB3PC2QlNMSC4tKwpsj0hnitVmmz-VTDZNQV9wzmK-P7A&oe=65C22662',
  //   ),
  // ];

  List<Product> _items = [];

  // bool _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((thisone) => thisone.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((thisone) => thisone.isFavorite).toList();
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((thisone) => thisone.id == id);
  }

  void addProduct(Product product) {
    final Product newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((thisone) => thisone.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('not have id..... products provider model');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((thisone) => thisone.id == id);
    notifyListeners();
  }

  Future<void> getAsync() async {
    var data = await BaseController().getBranchProducts();
    if (_items.isEmpty) {
      for (var element in data['success']) {
        _items.add(new Product(
            id: element['item_code'],
            price: double.parse(element['price'].toString()),
            description: element['item_description'],
            title: element['item_description'],
            imageUrl: element['image_url']));
      }
      notifyListeners();
    }
  }

  Future<void> getBranchProductsFromSharedPreferences() async {
    var data = await BaseController().getBranchProductsFromSharedPreferences();
    if (_items.isEmpty) {
      for (var element in data) {
        _items.add(new Product(
            id: element['item_code'],
            price: double.parse(element['price'].toString()),
            description: element['item_description'],
            title: element['item_description'],
            imageUrl: element['image_url']));
      }
      notifyListeners();
    }
  }
}
