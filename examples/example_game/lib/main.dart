import 'package:example_game/managers/game_manager.dart';
import 'package:example_game/pages/entry_page.dart';
import 'package:flutter/material.dart';

void main() {
  gameManager.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EntryPage(),
    );
  }
}