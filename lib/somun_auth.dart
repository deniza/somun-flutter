import 'package:somun_flutter/somun_interface.dart';

class SomunAuth extends SomunInterface {

  SomunAuth() : super("Auth");

  void loginUsingIdPassword(int playerId, String password, {Function? responseHandler}) {
    
    setResponseHandler("loginResponse", responseHandler);
    
    call('loginUsingIdPassword', [playerId, password]);

  }

  void loginUsingFacebook(String accessToken, {Function? responseHandler}) {
    
    setResponseHandler("facebookLoginResponse", responseHandler);
    
    call('loginUsingFacebook', [accessToken]);

  }

}