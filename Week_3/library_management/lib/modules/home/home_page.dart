import 'package:flutter/material.dart';
import '../books/book_page.dart';
import '../users/user_page.dart';
import '../borrow/borrow_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookPage()),
                );
              },
              child: const Text('Quản lý Sách'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UserPage()),
                );
              },
              child: const Text('Quản lý Người dùng'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BorrowPage()),
                );
              },
              child: const Text('Mượn Sách'),
            ),
          ],
        ),
      ),
    );
  }
}
