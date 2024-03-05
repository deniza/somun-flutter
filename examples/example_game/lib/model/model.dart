import 'package:flutter/material.dart';

GameList games = GameList();

class Game {

  int gameId;
  String gameName;

  Game({required this.gameId, required this.gameName});

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