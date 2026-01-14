// lazy_list_page.dart
import 'package:flutter/material.dart';

class LazyListPage extends StatefulWidget {
  const LazyListPage({super.key});

  @override
  State<LazyListPage> createState() => _LazyListPageState();
}

class _LazyListPageState extends State<LazyListPage> {
  final int itemCount = 1000000;
  final Stopwatch stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    stopwatch.stop();
    debugPrint(
      'Lazy ListView.builder initial build time: ${stopwatch.elapsedMilliseconds} ms',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Lazy ListView.builder')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade100,
            child: Text(
              'Initial build time: ${stopwatch.elapsedMilliseconds} ms',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
