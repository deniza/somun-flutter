library somun_flutter;

import 'package:somun_flutter/interface/somun_account.dart';
import 'package:somun_flutter/interface/somun_auth.dart';
import 'package:somun_flutter/interface/somun_friends.dart';
import 'package:somun_flutter/interface/somun_groups.dart';
import 'package:somun_flutter/interface/somun_play.dart';
import 'package:somun_flutter/somun_connection.dart';
import 'package:somun_flutter/interface/somun_rpc.dart';

final Somun somun = Somun._();

class Somun {

  final SomunAuth auth = SomunAuth();
  final SomunAccount account = SomunAccount();
  final SomunPlay play = SomunPlay();  
  final SomunFriends friends = SomunFriends();
  final SomunGroups groups = SomunGroups();  
  final SomunRpc rpc = SomunRpc();

  SomunConnection? _connection;

  Function onConnect = () {};
  Function onDisconnect = () {};
  
  Somun._();

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


