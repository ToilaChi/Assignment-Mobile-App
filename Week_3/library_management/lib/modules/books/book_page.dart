import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  void addBook() {
    if (titleController.text.isEmpty || authorController.text.isEmpty) return;

    context.read<LibraryProvider>().addBook(
      titleController.text,
      authorController.text,
    );

    titleController.clear();
    authorController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã thêm sách thành công!')));
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Sách')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tên sách',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'Tác giả',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addBook,
                    child: const Text('Thêm sách'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer<LibraryProvider>(
              builder: (context, provider, child) {
                if (provider.books.isEmpty) {
                  return const Center(child: Text('Chưa có sách nào'));
                }
                return ListView.builder(
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        trailing: Chip(
                          label: Text(
                            book.isAvailable ? 'Còn' : 'Đã mượn',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: book.isAvailable
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
