import 'package:example_game/managers/game_manager.dart';
import 'package:example_game/pages/lobby_page.dart';
import 'package:example_game/pages/login_page.dart';
import 'package:example_game/pages/new_account_page.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(              
                child: const Text('Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Register New Account'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewAccountPage()),
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Create Guest Account'),
                onPressed: () {
                  _createGuestAccount();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createGuestAccount() {

    gameManager.createGuestAccount((accepted) {

      if (accepted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LobbyPage()
        ));
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create guest account')),
        );

      }

    });

  }

}