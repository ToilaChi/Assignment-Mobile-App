import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String item) {
    return _favorites.contains(item);
  }

  void toggleFavorite(String item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }
}
