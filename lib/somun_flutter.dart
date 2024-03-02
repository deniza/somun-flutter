library somun_flutter;

import 'package:somun_flutter/somun_connection.dart';

class Somun {

  static SomunConnection? _connection;

  static void connect(String host, int port, void Function() onConnect, void Function() onDisconnect) {

    _connection = SomunConnection(onConnect, onDisconnect);
    _connection!.connect(host, port);

  }

  static void disconnect() {
    
    _connection?.disconnect();
    _connection = null;

  }

  static void call(String functionName, List params) {
    
    _connection?.call(functionName, params);

  }
  
}


