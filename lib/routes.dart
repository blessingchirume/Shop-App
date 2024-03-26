import 'package:flutter/material.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/screens/cancellation_request.dart';
import 'package:shop_app/screens/cancellations/index.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/draft_order_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/intiate_transfer_screen.dart';
import 'package:shop_app/screens/login_page/login_page_view.dart';
import 'package:shop_app/screens/print_widget.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/profile_page/profile_page_view.dart';
import 'package:shop_app/screens/transfer_screen.dart';
import 'package:shop_app/screens/transfers/reject_transfer_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutingConstants.login:
        return navigateToPage(const LoginPageView());
      case RoutingConstants.products:
        return navigateToPage(ProductsOverViewScreen());
      case RoutingConstants.productDetail:
        return navigateToPage(ProductDetailScreen());
      case RoutingConstants.cart:
        return navigateToPage(CartScreen());
      case RoutingConstants.userProducts:
        return navigateToPage(UserProductsScreen());
      case RoutingConstants.editProduct:
        return navigateToPage(EditProductScreen());
      case RoutingConstants.transfers:
        return navigateToPage(TransferScreen());
      case RoutingConstants.initiateTransfer:
        return navigateToPage(InitiateTransferSreen());
      case RoutingConstants.profile:
        return navigateToPage(ProfilePageView());
      case RoutingConstants.draftSales:
        return navigateToPage(DraftOrdersScreen());
      case RoutingConstants.cancellationRequest:
        return navigateToPage(CancellationRequestSCreen());
      case RoutingConstants.cancellationRequests:
        return navigateToPage(CancellationRequestsScreen());
      case RoutingConstants.davinci:
        return navigateToPage(App());
      default:
        return navigateToPage(const LoginPageView());
    }
  }

  static MaterialPageRoute<dynamic> navigateToPage(dynamic page) =>
      MaterialPageRoute(builder: (_) => page);
}
