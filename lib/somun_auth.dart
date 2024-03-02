import 'package:somun_flutter/somun_flutter.dart';
import 'package:somun_flutter/somun_interface.dart';

class SomunAuth extends SomunInterface {

  void loginUsingIdPassword(int playerId, String password, {Function? responseHandler}) {
    
    setResponseHandler("loginResponse", responseHandler);
    
    somun.call('Auth', 'loginUsingIdPassword', [playerId, password]);

  }

  void loginUsingFacebook(String accessToken, {Function? responseHandler}) {
    
    setResponseHandler("facebookLoginResponse", responseHandler);
    
    somun.call('Auth', 'loginUsingFacebook', [accessToken]);

  }

}