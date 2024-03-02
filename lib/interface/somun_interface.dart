import 'package:somun_flutter/somun_flutter.dart';

abstract class SomunInterface {

  final String moduleName;
  final Map<String, Function?> _responseHandlers = {};

  SomunInterface(this.moduleName);

  void call(String function, List params) {
    somun.call(moduleName, function, params);
  }

  void setResponseHandler(String function, Function? handler) {
    _responseHandlers[function] = handler;
  }
  
  void handleIncomingFunction(String function, List params) {    
    _responseHandlers[function]?.call(params);
  }

}