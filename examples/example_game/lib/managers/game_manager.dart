import 'package:somun_flutter/somun_flutter.dart';

GameManager gameManager = GameManager._();

class GameManager {

  final _host = 'localhost';
  final _port = 16666;

  GameManager._();

  void login(String username, String password, Function loginResponse) async {

    await somun.connect(_host, _port);

    somun.auth.loginUsingUsernamePassword(
      username,
      password,
      responseHandler: (params) {        
        if (params[0] == 1) {
          loginResponse(true);
        } else {
          loginResponse(false);
        }
    });

  }

}