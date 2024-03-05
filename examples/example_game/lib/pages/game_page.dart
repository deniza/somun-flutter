// create a game page that has a button that allows the user to guess a number
// this is a multiplayer game. the game page should also display both the players' names
// and scores. and should also have options to quit game and return to lobby

import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
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
                child: const Text('Quit Game'),
                onPressed: () {
                  _quitGame();
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

  void _quitGame() {
  }

}
