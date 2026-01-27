import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/auth_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar - không rebuild khi username thay đổi
                Selector<AuthManager, String>(
                  selector: (_, auth) => auth.avatarUrl,
                  builder: (_, avatarUrl, _) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatarUrl),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Username - chỉ rebuild khi username thay đổi
                Selector<AuthManager, String>(
                  selector: (_, auth) => auth.userName,
                  builder: (_, userName, _) {
                    return Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showChangeUsernameDialog(context);
                  },
                  label: const Text('Change Username'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChangeUsernameDialog(BuildContext context) {
    final controller = TextEditingController();
    final currentUsername = context.read<AuthManager>().userName;
    controller.text = currentUsername;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Change Username'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'New Username',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty && newName != currentUsername) {
                context.read<AuthManager>().updateUserName(newName);
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
