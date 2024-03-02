import 'package:somun_flutter/somun_flutter.dart';

class SomunAccount {

  final Map<String, Function?> _responseHandlers = {};

  void createGuestAccount({Function? acceptHandler, Function? rejectHandler}) {
    
    _responseHandlers['createGuestAccountAccepted'] = acceptHandler;
    _responseHandlers['createGuestAccountRejected'] = rejectHandler;
    
    somun.call('Account', 'createGuestAccount', []);

  }

  void createAccount(String username, String password, {Function? acceptHandler, Function? rejectHandler}) {
    
    _responseHandlers['createAccountAccepted'] = acceptHandler;
    _responseHandlers['createAccountRejected'] = rejectHandler;
    
    somun.call('Account', 'createAccount', [username, password]);

  }

  void changeCredentials(String username, String password, {Function? responseHandler}) {
    
    _responseHandlers['changeCredentialsResponse'] = responseHandler;
    
    somun.call('Account', 'changeCredentials', [username, password]);

  }

  void setNotificationToken(String token) {
    
    somun.call('Account', 'setNotificationToken', [token]);

  }

  void handleIncomingFunction(String function, List params) {
    
    _responseHandlers[function]?.call(params);

  }

}