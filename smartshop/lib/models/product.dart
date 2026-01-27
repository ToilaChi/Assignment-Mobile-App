class Product {
  final String id;
  final String name;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
}
