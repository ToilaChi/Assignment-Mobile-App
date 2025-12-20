import '../models/payment_method.dart';

final List<PaymentMethod> paymentMethods = [
  PaymentMethod(id: 'paypal', name: 'PayPal', icon: 'assets/icons/paypal.png'),
  PaymentMethod(
    id: 'google',
    name: 'Google Pay',
    icon: 'assets/icons/google.png',
  ),
  PaymentMethod(id: 'apple', name: 'Apple Pay', icon: 'assets/icons/apple.png'),
];
