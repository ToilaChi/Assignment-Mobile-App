import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/cart_manager.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          ...cart.items.values.map(
            (item) => ListTile(
              title: Text(item.product.name),
              trailing: Text('x${item.quantity}'),
            ),
          ),
          Text('Total: \$${cart.totalPrice}'),
          ElevatedButton(
            onPressed: cart.totalItems == 0
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CheckoutPage()),
                    );
                  },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
