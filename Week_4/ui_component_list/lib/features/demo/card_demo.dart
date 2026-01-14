import 'package:flutter/material.dart';

class CardDemo extends StatelessWidget {
  const CardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Components')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Card'),
              ),
            ),
            Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('Chip')),
                Chip(label: Text('Flutter')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
