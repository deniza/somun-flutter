import 'package:somun_flutter/somun_flutter.dart';

class SomunAccount {

  final Map<String, Function?> _responseHandlers = {};

  void createGuestAccount({Function? acceptHandler, Function? rejectHandler}) {
    
    _responseHandlers['createGuestAccountAccepted'] = acceptHandler;
    _responseHandlers['createGuestAccountRejected'] = rejectHandler;
    
    somun.call('Account', 'createGuestAccount', []);

  }

  void handleIncomingFunction(String function, List params) {
    
    _responseHandlers[function]?.call(params);

  }

}