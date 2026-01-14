import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleUIPage(),
    );
  }
}

class SimpleUIPage extends StatefulWidget {
  const SimpleUIPage({super.key});

  @override
  State<SimpleUIPage> createState() => _SimpleUIPageState();
}

class _SimpleUIPageState extends State<SimpleUIPage> {
  String displayText = "Hello World";

  void toggleText() {
    setState(() {
      displayText = displayText == "Hello World" ? "Toi la Chi" : "Hello World";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "My Awesome App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            Text(displayText, style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: toggleText,
              child: const Text("He so lo"),
            ),
          ],
        ),
      ),
    );
  }
}
