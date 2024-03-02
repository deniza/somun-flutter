import 'package:somun_flutter/somun_flutter.dart';

class SomunAuth {

  final Map<String, Function?> _responseHandlers = {};

  void loginUsingIdPassword(int playerId, String password, {Function? responseHandler}) {
    
    _responseHandlers['loginResponse'] = responseHandler;
    
    somun.call('Auth', 'loginUsingIdPassword', [playerId, password]);

  }

  void loginUsingFacebook(String accessToken, {Function? responseHandler}) {
    
    _responseHandlers['facebookLoginResponse'] = responseHandler;
    
    somun.call('Auth', 'loginUsingFacebook', [accessToken]);

  }

  void handleIncomingFunction(String function, List params) {
    
    _responseHandlers[function]?.call(params);

  }

}