// normal_list_page.dart
import 'package:flutter/material.dart';

class NormalListPage extends StatefulWidget {
  const NormalListPage({super.key});

  @override
  State<NormalListPage> createState() => _NormalListPageState();
}

class _NormalListPageState extends State<NormalListPage> {
  final int itemCount = 1000000;
  late Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      itemCount,
      (index) => ListTile(title: Text('Item $index')),
    );

    stopwatch.stop();
    debugPrint(
      'Normal ListView build time: ${stopwatch.elapsedMilliseconds} ms',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Normal ListView')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.red.shade100,
            child: Text(
              'Build time: ${stopwatch.elapsedMilliseconds} ms',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: ListView(children: items)),
        ],
      ),
    );
  }
}
