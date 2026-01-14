import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_model.dart';

class ItemTile extends StatelessWidget {
  final String item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    debugPrint('Build ItemTile shell: $item');

    return ListTile(
      title: Text(item),
      trailing: Selector<FavoriteModel, bool>(
        selector: (_, model) => model.isFavorite(item),
        builder: (_, isFav, _) {
          debugPrint('Rebuild ICON of $item');

          return IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              context.read<FavoriteModel>().toggleFavorite(item);
            },
          );
        },
      ),
    );
  }
}
