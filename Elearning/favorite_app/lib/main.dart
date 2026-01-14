import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/favorite_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
