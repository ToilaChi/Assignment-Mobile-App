import 'package:flutter/material.dart';

class DisplayDemo extends StatelessWidget {
  const DisplayDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Components')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Text Widget
            Text(
              'Text Widget',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Hello Flutter', style: TextStyle(fontSize: 20)),

            SizedBox(height: 24),

            // Icon
            Text(
              'Icon',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Icon(Icons.favorite, color: Colors.red, size: 40),

            SizedBox(height: 24),

            // CircleAvatar
            Text(
              'CircleAvatar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CircleAvatar(radius: 30, child: Icon(Icons.person)),

            SizedBox(height: 24),

            Divider(),

            SizedBox(height: 24),

            // Flutter Logo
            Text(
              'FlutterLogo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            FlutterLogo(size: 60),
          ],
        ),
      ),
    );
  }
}
