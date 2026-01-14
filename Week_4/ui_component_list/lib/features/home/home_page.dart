import 'package:flutter/material.dart';
import '../components/components_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 120),
              const SizedBox(height: 24),
              const Text(
                'Flutter UI Components',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Ứng dụng demo các UI Components cơ bản trong Flutter',
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ComponentsPage()),
                  );
                },
                child: const Text("I'm ready"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
