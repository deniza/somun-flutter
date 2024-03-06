// create a game page that has a button that allows the user to guess a number
// this is a multiplayer game. the game page should also display both the players' names
// and scores. and should also have options to quit game and return to lobby

import 'package:example_game/managers/game_manager.dart';
import 'package:example_game/model/model.dart';
import 'package:example_game/util/util.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  void initState() {    
    super.initState();
    games.addListener(_updateUI);
  }

  @override
  void dispose() {
    games.removeListener(_updateUI);
    super.dispose();
  }

  void _updateUI() {
    setState(() {      
    });
  }

  @override
  Widget build(BuildContext context) {

    Game game = gameManager.currentGame!;

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
        child: game.gameState!.isFinished() ? _buildFinishGame() : _buildGame(),
      ),
    );
  }

  Widget _buildGame() {

    Game game = gameManager.currentGame!;
    bool isMyTurn = game.turnOwnerId == gameManager.playerId;
    MoveStatus lastMoveStatus = game.gameState!.lastMoveStatus;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isMyTurn ? ElevatedButton(
            child: const Text('Guess Number'),
            onPressed: () {
              _guessNumber();
            },
          ) : Column(
            children: [
              lastMoveStatus == MoveStatus.targetIsBelow ? const Text('You guessed a number higher than the target') : const Text('You guessed a number lower than the target'),
              const Text('Waiting for opponent to guess number'),
            ],
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
    );

  }

  Widget _buildFinishGame() {

    Game game = gameManager.currentGame!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Winner: ${game.gameState!.winnerId}'),
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
    );
  }

  void _guessNumber() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController numberController = TextEditingController();

        return AlertDialog(
          title: const Text('Guess a Number'),
          content: TextFormField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter a number',
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(numberController.text);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        // Handle the submitted number
        int? number = int.tryParse(value);
        if (number != null) {
          
          gameManager.guessNumber(number, (accepted) {
            if (!accepted) {
              showSnackBar(context, 'Failed to guess number');              
            }
          });

        } else {
          showSnackBar(context, 'Invalid number');
        }
      }
    });
  }

  void _leaveGame() {

    gameManager.leaveGame((accepted) {
      if (accepted) {
        Navigator.pop(context);
      } else {
        showSnackBar(context, 'Failed to leave game');
      }
    });

  }
}
