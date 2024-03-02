import 'package:somun_flutter/somun_flutter.dart';

abstract class SomunInterface {

  static Map<String, SomunInterface> _interfaces = Map();

  final String moduleName;
  final Map<String, Function?> _responseHandlers = {};

  SomunInterface(this.moduleName) {
    _interfaces[moduleName] = this;
  }

  void call(String function, List params) {
    somun.call(moduleName, function, params);
  }

  void setResponseHandler(String function, Function? handler) {
    _responseHandlers[function] = handler;
  }
  
  static void handleFunctionCall(String module, String function, List params) {
    _interfaces[module]?._responseHandlers[function]?.call(params);
  }

}