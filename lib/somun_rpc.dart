import 'package:somun_flutter/somun_flutter.dart';

class SomunRpc {

  final Map<String, Function?> _responseHandlers = {};

  void call(String functionName, String jsonData) {

    somun.call('Rpc', "call", [functionName, jsonData]);

  }

  void test(String p1, int p2) {

    somun.call('Rpc', "test", [p1, p2]);

  }

  void handleIncomingFunction(String function, List params) {

    _responseHandlers[function]?.call(params);

  }

}