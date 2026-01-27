import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'managers/auth_manager.dart';
import 'managers/product_manager.dart';
import 'managers/cart_manager.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SmartShopApp());
}

class SmartShopApp extends StatelessWidget {
  const SmartShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthManager()),
        ChangeNotifierProvider(create: (_) => ProductManager()),
        ChangeNotifierProvider(create: (_) => CartManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SmartShop Demo',
        home: const HomePage(),
      ),
    );
  }
}
