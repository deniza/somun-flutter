import 'package:somun_flutter/somun_flutter.dart';

GameManager gameManager = GameManager._();

class GameManager {

  final _host = 'localhost';
  final _port = 16666;

  GameManager._();

  void connect() {
    somun.connect(_host, _port);
  }

  void login(String username, String password, Function response) async {

    somun.auth.loginUsingUsernamePassword(
      username,
      password,
      responseHandler: (params) {        
        if (params[0] == 1) {
          response(true);
        } else {
          response(false);
        }
    });

  }

  void createGuestAccount(Function response) async {

    somun.account.createGuestAccount(
      acceptHandler: (params) {
        response(true);
      },
      rejectHandler: (params) {
        response(false);
      }
    );

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

}