import 'package:somun_flutter/somun_flutter.dart';

class SomunIncomingFunctionHandler {
  
  void incomingFunction(String functionName, List params) {

    final args = functionName.split('_');
    final module = args[0];
    final function = args[1];

    print("Incoming Function: ${module}_$function $params");

    if (module == 'Auth') {
      somun.auth.handleIncomingFunction(function, params);
    }
    else if (module == 'Account') {
      somun.account.handleIncomingFunction(function, params);
    }
    else if (module == 'Rpc') {
      somun.rpc.handleIncomingFunction(function, params);
    }
    
  }

}