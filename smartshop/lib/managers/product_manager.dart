import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductManager extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: 'p1', name: 'iPhone 15', price: 999),
    Product(id: 'p2', name: 'MacBook Pro', price: 1999),
    Product(id: 'p3', name: 'AirPods Pro', price: 249),
  ];

  List<Product> get products => _products;

  Product findById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }

  void toggleFavorite(String productId) {
    final product = findById(productId);
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
