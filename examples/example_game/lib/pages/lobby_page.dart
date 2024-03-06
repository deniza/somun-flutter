import 'package:example_game/managers/game_manager.dart';
import 'package:example_game/model/model.dart';
import 'package:example_game/pages/game_page.dart';
import 'package:flutter/material.dart';
import 'package:example_game/util/util.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Create New Game'),
                    onPressed: () {
                      _createGame();
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      _logout();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(games.getGame(index).gameName),
                    onTap: () {
                      _enterGame(games.getGame(index).gameId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createGame() {
    // create a game
  }

  void _enterGame(int gameId) {

    gameManager.enterGame(gameId, (accepted) {

      if (accepted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GamePage()),
        );
      } else {
        showSnackBar(context, 'Failed to enter game');
      }

    });

  }

  void _logout() {
    
    gameManager.disconnect();
    Navigator.pop(context);

    Future.delayed(const Duration(milliseconds: 100), () {
      gameManager.connect();      
    });    
  }

}