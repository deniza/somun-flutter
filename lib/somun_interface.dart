abstract class SomunInterface {

  final Map<String, Function?> _responseHandlers = {};

  void setResponseHandler(String function, Function? handler) {
    _responseHandlers[function] = handler;
  }
  
  void handleIncomingFunction(String function, List params) {    
    _responseHandlers[function]?.call(params);
  }

}