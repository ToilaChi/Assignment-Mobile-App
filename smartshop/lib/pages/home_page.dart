import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/product_manager.dart';
import '../widgets/product_item.dart';
import '../widgets/cart_badge.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductManager>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartShop'),
        actions: [
          IconButton(
            icon: const CartBadge(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: ListView(children: products.map((p) => ProductItem(p)).toList()),
    );
  }
}
