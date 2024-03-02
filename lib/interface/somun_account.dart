import 'package:somun_flutter/interface/somun_interface.dart';

class SomunAccount extends SomunInterface {

  SomunAccount() : super("Account");

  void createGuestAccount({Function? acceptHandler, Function? rejectHandler}) {
    
    setResponseHandler("createGuestAccountAccepted", acceptHandler);
    setResponseHandler("createGuestAccountRejected", rejectHandler);
    
    call('createGuestAccount', []);

  }

  void createAccount(String username, String password, {Function? acceptHandler, Function? rejectHandler}) {
    
    setResponseHandler("createAccountAccepted", acceptHandler);
    setResponseHandler("createAccountRejected", rejectHandler);

    call('createAccount', [username, password]);

  }

  void changeCredentials(String username, String password, {Function? responseHandler}) {
    
    setResponseHandler("changeCredentialsResponse", responseHandler);
    
    call('changeCredentials', [username, password]);

  }

  void setNotificationToken(String token) {
    
    call('setNotificationToken', [token]);

  }

}