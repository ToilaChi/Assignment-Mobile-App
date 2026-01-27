import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier {
  String _userName = 'Chi';
  final String avatarUrl = 'assets/images/IMG_1767624985629_1767624998824.jpg';

  String get userName => _userName;

  void updateUserName(String newName) {
    if (newName.trim().isNotEmpty && newName != _userName) {
      _userName = newName;
      notifyListeners();
    }
  }
}
