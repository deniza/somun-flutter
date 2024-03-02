import 'package:somun_flutter/somun_flutter.dart';
import 'package:somun_flutter/somun_interface.dart';

class SomunAccount extends SomunInterface {

  void createGuestAccount({Function? acceptHandler, Function? rejectHandler}) {
    
    setResponseHandler("createGuestAccountAccepted", acceptHandler);
    setResponseHandler("createGuestAccountRejected", rejectHandler);
    
    somun.call('Account', 'createGuestAccount', []);

  }

  void createAccount(String username, String password, {Function? acceptHandler, Function? rejectHandler}) {
    
    setResponseHandler("createAccountAccepted", acceptHandler);
    setResponseHandler("createAccountRejected", rejectHandler);

    somun.call('Account', 'createAccount', [username, password]);

  }

  void changeCredentials(String username, String password, {Function? responseHandler}) {
    
    setResponseHandler("changeCredentialsResponse", responseHandler);
    
    somun.call('Account', 'changeCredentials', [username, password]);

  }

  void setNotificationToken(String token) {
    
    somun.call('Account', 'setNotificationToken', [token]);

  }

}