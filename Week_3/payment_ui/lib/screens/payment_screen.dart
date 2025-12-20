import 'package:flutter/material.dart';
import '../data/payment_data.dart';
import '../models/payment_method.dart';
import '../widgets/payment_item.dart';
import '../widgets/continue_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Choose payment'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: selectedMethod != null
                  ? Image.asset(
                      selectedMethod!.icon,
                      height: 100,
                      width: 150,
                      fit: BoxFit.contain,
                    )
                  : const Icon(
                      Icons.add_business_sharp,
                      size: 120,
                      color: Colors.black87,
                    ),
            ),
            const SizedBox(height: 60),
            ...paymentMethods.map((method) {
              return PaymentItem(
                method: method,
                isSelected: selectedMethod?.id == method.id,
                onTap: () {
                  setState(() {
                    selectedMethod = (selectedMethod?.id == method.id)
                        ? null
                        : method;
                  });
                },
              );
            }),

            const Spacer(),

            /// CHỈ SHOW KHI ĐÃ CHỌN PAYMENT
            if (selectedMethod != null)
              ContinueButton(
                onPressed: () {
                  print('Selected: ${selectedMethod!.name}');
                },
              ),
          ],
        ),
      ),
    );
  }
}
