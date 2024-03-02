import 'package:somun_flutter/somun_flutter.dart';

class SomunAuth {

  void loginUsingIdPassword(int playerId, String password) {
    
    somun.call('Auth', 'loginUsingIdPassword', [playerId, password]);

  }

}