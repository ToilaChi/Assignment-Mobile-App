import 'package:flutter/material.dart';
import 'favorite_screen.dart';
import '../widgets/item_tile.dart';

class HomeScreen extends StatelessWidget {
  final items = List.generate(10, (index) => 'Item $index');

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Items'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.favorite),
              style: IconButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoriteScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ItemTile(item: items[index]);
        },
      ),
    );
  }
}
