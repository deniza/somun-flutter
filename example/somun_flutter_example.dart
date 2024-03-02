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

  somun.account.createGuestAccount(
    acceptHandler: (params) {
      print('Guest account created: $params');
    },
    rejectHandler: (params) {
      print('Guest account creation failed: $params');
    }
  );

  await Future.delayed(const Duration(seconds: 2));

  somun.disconnect();

}
