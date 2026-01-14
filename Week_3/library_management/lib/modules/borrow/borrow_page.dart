import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../models/user.dart';
import '../../providers/library_provider.dart';

class BorrowPage extends StatefulWidget {
  const BorrowPage({super.key});

  @override
  State<BorrowPage> createState() => _BorrowPageState();
}

class _BorrowPageState extends State<BorrowPage> {
  Book? selectedBook;
  User? selectedUser;

  void borrowBook() {
    if (selectedBook == null || selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn người dùng và sách'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<LibraryProvider>().borrowBook(selectedBook!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${selectedUser!.name} đã mượn "${selectedBook!.title}"'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      selectedBook = null;
      selectedUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mượn Sách')),
      body: Consumer<LibraryProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Chọn người dùng
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<User>(
                      hint: const Text('Chọn người dùng'),
                      value: selectedUser,
                      isExpanded: true,
                      items: provider.users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: Text(user.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUser = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Chọn sách
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<Book>(
                      hint: const Text('Chọn sách'),
                      value: selectedBook,
                      isExpanded: true,
                      items: provider.availableBooks.map((book) {
                        return DropdownMenuItem(
                          value: book,
                          child: Text(book.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBook = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: provider.availableBooks.isEmpty
                      ? null
                      : borrowBook,
                  icon: const Icon(Icons.book),
                  label: const Text('Mượn'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 24),
                // Thống kê
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thống kê',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Tổng số sách: ${provider.books.length}'),
                        Text(
                          'Sách còn có thể mượn: ${provider.availableBooks.length}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Sách đã được mượn: ${provider.books.length - provider.availableBooks.length}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
