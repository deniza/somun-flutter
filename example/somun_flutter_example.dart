import 'package:somun_flutter/somun_flutter.dart';

void main() async {

  final host = 'localhost';
  final port = 16666;
  final playerId = 1;
  final password = '';

  somun.onConnect = () {
    print('Connected');
  };

  somun.onDisconnect = () {
    print('Disconnected');
  };

  await somun.connect(host, port);
  somun.auth.loginUsingIdPassword(playerId, password);

  await Future.delayed(const Duration(seconds: 2));

  somun.disconnect();

}
