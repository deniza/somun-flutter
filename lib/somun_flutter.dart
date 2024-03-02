library somun_flutter;

import 'package:somun_flutter/somun_auth.dart';
import 'package:somun_flutter/somun_connection.dart';

final Somun somun = Somun._();

class Somun {

  SomunConnection? _connection;
  late final SomunAuth _auth;
  
  SomunAuth get auth => _auth;

  Somun._() {
    _auth = SomunAuth();
  }

  void connect(String host, int port, void Function() onConnect, void Function() onDisconnect) {

    _connection = SomunConnection(onConnect, onDisconnect);
    _connection!.connect(host, port);

  }

  void disconnect() {
    
    _connection?.disconnect();
    _connection = null;

  }

  void call(String functionName, List params) {
    
    _connection?.call(functionName, params);

  }
  
}


