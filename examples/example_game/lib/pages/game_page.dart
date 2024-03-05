// create a game page that has a button that allows the user to guess a number
// this is a multiplayer game. the game page should also display both the players' names
// and scores. and should also have options to quit game and return to lobby

import 'package:example_game/managers/game_manager.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _leaveGame();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Guess Number'),
                onPressed: () {
                  _guessNumber();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Leave Game'),
                onPressed: () {
                  _leaveGame();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _guessNumber() {
  }

  void _leaveGame() {

    gameManager.leaveGame((accepted) {
      if (accepted) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to leave game'),
          ),
        );
      }
    });

  }
}
