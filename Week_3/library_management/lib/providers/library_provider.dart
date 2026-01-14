import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/user.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Book> _books = [
    Book(title: 'Flutter Basics', author: 'Google'),
    Book(title: 'Dart Language', author: 'Dart Team'),
  ];

  final List<User> _users = [
    User(name: 'Nguyễn Văn A'),
    User(name: 'Trần Văn B'),
  ];

  List<Book> get books => _books;
  List<User> get users => _users;

  // Thêm sách
  void addBook(String title, String author) {
    _books.add(Book(title: title, author: author));
    notifyListeners();
  }

  // Thêm người dùng
  void addUser(String name) {
    _users.add(User(name: name));
    notifyListeners();
  }

  // Mượn sách
  void borrowBook(Book book) {
    book.isAvailable = false;
    notifyListeners();
  }

  // Trả sách
  void returnBook(Book book) {
    book.isAvailable = true;
    notifyListeners();
  }

  // Lấy danh sách sách còn có thể mượn
  List<Book> get availableBooks =>
      _books.where((book) => book.isAvailable).toList();
}
