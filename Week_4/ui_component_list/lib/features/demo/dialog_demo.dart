import 'package:flutter/material.dart';

class DialogDemo extends StatelessWidget {
  const DialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Components')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('AlertDialog'),
                content: const Text('This is a dialog'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }
}
