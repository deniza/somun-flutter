import 'package:somun_flutter/interface/somun_interface.dart';

class SomunRpc extends SomunInterface {

  SomunRpc() : super("Rpc");

  void rpc(String functionName, String jsonData) {

    call("call", [functionName, jsonData]);

  }

  void test(String p1, int p2) {

    call("test", [p1, p2]);

  }

}