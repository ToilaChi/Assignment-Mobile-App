import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final nameController = TextEditingController();

  void addUser() {
    if (nameController.text.isEmpty) return;

    context.read<LibraryProvider>().addUser(nameController.text);

    nameController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã thêm người dùng thành công!')),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Người dùng')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên người dùng',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: addUser, child: const Text('Thêm')),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer<LibraryProvider>(
              builder: (context, provider, child) {
                if (provider.users.isEmpty) {
                  return const Center(child: Text('Chưa có người dùng nào'));
                }
                return ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    final user = provider.users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(user.name[0])),
                        title: Text(user.name),
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
