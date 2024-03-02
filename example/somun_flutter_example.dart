import 'package:somun_flutter/somun_flutter.dart';

void main() {

  somun.connect("localhost", 16666, () {
    print("Connected");

    somun.auth.loginUsingIdPassword(1, "password");

    Future.delayed(Duration(seconds: 2), () {
      somun.disconnect();      
    });

  }, () {
    print("Disconnected");
  });



}
