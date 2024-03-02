library somun_flutter;

import 'package:somun_flutter/somun_account.dart';
import 'package:somun_flutter/somun_auth.dart';
import 'package:somun_flutter/somun_connection.dart';

final Somun somun = Somun._();

class Somun {

  late final SomunAuth auth;
  late final SomunAccount account;

  SomunConnection? _connection;

  Function onConnect = () {};
  Function onDisconnect = () {};
  
  Somun._() {
    auth = SomunAuth();
    account = SomunAccount();
  }

  Future connect(String host, int port) {

    _connection = SomunConnection(() {
      onConnect.call();
    }, () {
      onDisconnect.call();
    });
    
    return _connection!.connect(host, port);

  }

  void disconnect() {
    
    _connection?.disconnect();
    _connection = null;

  }

  void call(String module, String functionName, List params) {
    
    _connection?.call(module, functionName, params);

  }
  
}


