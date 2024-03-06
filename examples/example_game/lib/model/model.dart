import 'dart:convert';

import 'package:flutter/material.dart';

GameList games = GameList();

class Game {

  int gameId;
  int turnOwnerId = -1;
  String gameName;
  GameState? gameState;

  Game({required this.gameId, required this.gameName});

  void setGameState(GameState gameState) {
    this.gameState = gameState;
  }

}

enum MoveStatus {
  targetIsBelow,
  targetIsAbove
}

class GameState {

  final String _json;
  
  int winnerId = -1;
  int numberToFind = -1;
  MoveStatus lastMoveStatus = MoveStatus.targetIsBelow;
  
  GameState(this._json) {

    jsonDecode(_json, reviver: (key, value) {
      if (key == 'winner') {
        winnerId = _toInt(value);
      }
      else if (key == 'target') {
        lastMoveStatus = _toInt(value) == -1 ? MoveStatus.targetIsBelow : MoveStatus.targetIsAbove;
      }
      else if (key == 'numberToFind') {
        numberToFind = _toInt(value);
      }
      return value;
    });


  }

  int _toInt(numberObject) {    
    return numberObject.toInt();
  }

  bool isFinished() {
    return winnerId != -1;
  }

}

class GameList extends ChangeNotifier {

  List<Game> games = [];

  void clear() {
    games.clear();
  }

  void addGame(Game game) {
    games.add(game);
  }

  void removeGame(Game game) {
    games.remove(game);
  }

  void removeGameByIndex(int index) {
    games.removeAt(index);
  }

  Game getGame(int index) {
    return games[index];
  }

  Game getGameById(int gameId) {
    return games.firstWhere((game) => game.gameId == gameId);
  }

  int get length {
    return games.length;
  }

  bool get isEmpty {
    return games.isEmpty;
  }

  bool get isNotEmpty {
    return games.isNotEmpty;
  }

  void notify() {
    notifyListeners();
  }

}