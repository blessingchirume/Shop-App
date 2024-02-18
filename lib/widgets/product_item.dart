import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    print('product item widget wac rebuild;');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: product.imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress))),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(product.title!, textAlign: TextAlign.center),
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              onPressed: () => product.toggleFavoriteStatus(),
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              iconSize: 20,
              color: Colors.deepOrange,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id!, product.title!, product.price!);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart!.'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () => cart.removeSingleItem(product.id!),
                ),
              ));
            },
            icon: Icon(Icons.shopping_cart),
            iconSize: 20,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
