import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Consumer<FavoriteModel>(
        builder: (_, model, _) {
          if (model.favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView(
            children: model.favorites
                .map((item) => ListTile(title: Text(item)))
                .toList(),
          );
        },
      ),
    );
  }
}
