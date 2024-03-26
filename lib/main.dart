import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/providers/currency.dart';
import 'package:shop_app/providers/draft_order.dart';
import 'package:shop_app/providers/transfer.dart';
import 'package:shop_app/providers/user.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/services/background_transaction_service.dart';
import 'package:workmanager/workmanager.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

String task = 're-initialize-failed-sales';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    BackgroundTransactionService().createTransaction();
    print(taskName);
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Workmanager().registerPeriodicTask(
      DateTime.now().toString(),
      task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TransferProvider()),
        ChangeNotifierProvider(create: (context) => OfflineOrderProvider()),
        ChangeNotifierProvider(create: (context) => Currency()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(secondary: Colors.deepOrange),
        ),
        initialRoute: RoutingConstants.login,
        onGenerateRoute: RouteGenerator.generateRoute,
        // routes: {
        //   '/': (context) => ProductsOverViewScreen(),
        //   ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        //   CartScreen.routeName: (context) => CartScreen(),
        //   OrdersScreen.routeName: (context) => OrdersScreen(),
        //   UserProductsScreen.routeName: (context) => UserProductsScreen(),
        //   EditProductScreen.routeName: (context) => EditProductScreen(),
        //   LoginPageView.routeName:(context) => LoginPageView()
        // },
      ),
    );
  }
}
