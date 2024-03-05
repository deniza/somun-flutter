import 'package:example_game/pages/game_page.dart';
import 'package:flutter/material.dart';

// create a new stateless widget called LobbyPage that has a list that lists strings

class LobbyPage extends StatelessWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Game 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Game 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Game 3'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}