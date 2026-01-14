import 'package:flutter/material.dart';

class InputDemo extends StatefulWidget {
  const InputDemo({super.key});

  @override
  State<InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  bool checked = false;
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Components')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'TextField'),
            ),
            CheckboxListTile(
              title: const Text('Checkbox'),
              value: checked,
              onChanged: (v) => setState(() => checked = v!),
            ),
            Switch(
              value: checked,
              onChanged: (v) => setState(() => checked = v),
            ),
            Slider(value: value, onChanged: (v) => setState(() => value = v)),
          ],
        ),
      ),
    );
  }
}
