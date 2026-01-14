import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/cart_manager.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CartManager, int>(
      selector: (_, cart) => cart.totalItems,
      builder: (_, count, _) {
        return Stack(
          children: [
            const Icon(Icons.shopping_cart),
            if (count > 0)
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    count.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
