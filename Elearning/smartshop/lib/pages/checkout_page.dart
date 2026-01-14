import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/cart_manager.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Selector để chỉ rebuild khi totalPrice thay đổi
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.payment, size: 64, color: Colors.green),
                const SizedBox(height: 24),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Selector<CartManager, double>(
                  selector: (_, cart) => cart.totalPrice,
                  builder: (_, total, __) {
                    return Text(
                      'Total Payment: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.check_circle),
                  onPressed: () {
                    // Clear cart và trigger rebuild
                    context.read<CartManager>().clearCart();

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment successful!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Navigate về home
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  label: const Text('Confirm Payment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
