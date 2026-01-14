import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget {
  const ListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Components')),
      body: ListView(
        children: [
          ListTile(title: const Text('ListTile')),
          ExpansionTile(
            title: const Text('ExpansionTile'),
            children: const [ListTile(title: Text('Child item'))],
          ),
          SizedBox(
            height: 100,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                6,
                (i) => Card(child: Center(child: Text('$i'))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
