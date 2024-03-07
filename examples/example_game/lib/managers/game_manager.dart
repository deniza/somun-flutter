import 'dart:convert';

import 'package:example_game/model/model.dart';
import 'package:somun_flutter/somun_flutter.dart';

GameManager gameManager = GameManager._();

class GameManager {

  final _host = 'localhost';
  final _port = 16666;

  Game? currentGame;
  int playerId = 0;

  GameManager._() {

    somun.play.setResponseHandler("gameFinished", (params) {
      int gameId = params[0];
      int winnerId = params[1];
      String gameState = params[2];

      Game game = games.getGameById(gameId);
      game.setGameState(GameState(gameState));
      game.gameState!.winnerId = winnerId;

      games.notify();
    });

    somun.play.setResponseHandler("gameStateUpdated", (params) {
      int gameId = params[0];
      String gameState = params[1];

      Game game = games.getGameById(gameId);
      game.setGameState(GameState(gameState));

      games.notify();
    });

    somun.play.setResponseHandler("turnOwnerChanged", (params) {
      int gameId = params[0];
      int turnOwner = params[1];

      Game game = games.getGameById(gameId);
      game.turnOwnerId = turnOwner;

      games.notify();
    });


  }

  void connect() {
    somun.connect(_host, _port);
  }

  void disconnect() {
    somun.disconnect();
  }

  void login(String username, String password, Function response) async {

    somun.auth.loginUsingUsernamePassword(
      username,
      password,
      responseHandler: (params) {        
        if (params[0] == 1) {
          playerId = params[1];
          response(true);
        } else {
          response(false);
        }
    });

  }

  void createAccount(String username, String password, Function response) async {

    somun.account.createAccount(
      username,
      password,
      acceptHandler: (params) {
        response(true);
      },
      rejectHandler: (params) {
        response(false);
      }
    );

  }

  void getGameList() async {

    somun.play.listGames(
      responseHandler: (params) {
        
        games.clear();
        for (final gameId in params[0]) {
          games.addGame(Game(gameId: gameId, gameName: "Game: $gameId"));
        }

        games.notify();

      }
    );

  }

  void enterGame(int gameId, Function response) async {

    somun.play.enterGame(
      gameId,
      responseHandler: (params) {
        if (params[0] == 1) {

          bool completed = params[1] == 1;
          int turnOwner = params[2];
          int winner = params[3];
          String gameState = params[4];

          currentGame = games.getGameById(gameId);
          currentGame?.turnOwnerId = turnOwner;
          currentGame?.setGameState(GameState(gameState));

          response(true);
        } else {          
          response(false);
        }
      }
    );

  }

  void leaveGame(Function response) async {

    somun.play.exitGame(
      currentGame!.gameId,
      responseHandler: (params) {
        if (params[0] == 1) {
          currentGame = null;
          response(true);
        } else {
          response(false);
        }
      }
    );

  }  

  void guessNumber(int number, Function response) async {

    somun.play.makeMove(
      currentGame!.gameId,
      jsonEncode({'number': number}),
      responseHandler: (params) {
        if (params[0] == 1) {
          response(true);
        } else {
          response(false);
        }
      }
    );

  }

}