import 'package:flutter/material.dart';
import '../../core/models/component_item.dart';
import '../demo/layout_demo.dart';
import '../demo/display_demo.dart';
import '../demo/input_demo.dart';
import '../demo/button_demo.dart';
import '../demo/list_demo.dart';
import '../demo/navigation_demo.dart';
import '../demo/dialog_demo.dart';
import '../demo/card_demo.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ComponentItem(
        title: 'Layout',
        subtitle: 'Row, Column, Stack...',
        page: const LayoutDemo(),
      ),
      ComponentItem(
        title: 'Display',
        subtitle: 'Text, Image, Icon...',
        page: const DisplayDemo(),
      ),
      ComponentItem(
        title: 'Input',
        subtitle: 'TextField, Switch...',
        page: const InputDemo(),
      ),
      ComponentItem(
        title: 'Buttons',
        subtitle: 'Elevated, FAB...',
        page: const ButtonDemo(),
      ),
      ComponentItem(
        title: 'Lists',
        subtitle: 'ListView, GridView...',
        page: const ListDemo(),
      ),
      ComponentItem(
        title: 'Navigation',
        subtitle: 'AppBar, Drawer...',
        page: const NavigationDemo(),
      ),
      ComponentItem(
        title: 'Dialogs',
        subtitle: 'Alert, SnackBar...',
        page: const DialogDemo(),
      ),
      ComponentItem(
        title: 'Cards',
        subtitle: 'Card, Chip...',
        page: const CardDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('UI Components List')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => ListTile(
          tileColor: Colors.blue.withValues(alpha: 0.08),
          title: Text(items[i].title),
          subtitle: Text(items[i].subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => items[i].page),
          ),
        ),
      ),
    );
  }
}
