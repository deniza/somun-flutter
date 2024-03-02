import 'package:somun_flutter/somun_flutter.dart';

void main() {

  Somun.connect("localhost", 16666, () {
    print("Connected");

    Somun.call("Rpc_test", ["hello", 1]);

    Future.delayed(Duration(seconds: 2), () {
      Somun.disconnect();      
    });

  }, () {
    print("Disconnected");
  });



}
