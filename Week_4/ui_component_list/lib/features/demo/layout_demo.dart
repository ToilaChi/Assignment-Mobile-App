import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Components')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(height: 50, color: Colors.blue),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Container(height: 50, color: Colors.red)),
                const SizedBox(width: 8),
                Expanded(child: Container(height: 50, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(height: 80, color: Colors.grey),
                const Positioned(bottom: 8, right: 8, child: Text('Stack')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
