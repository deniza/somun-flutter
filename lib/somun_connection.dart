import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'read_buffer.dart';
import 'packet_builder.dart';
import 'somun_param_types.dart';

class SomunConnection {

  final Duration defaultConnectionTimeout = const Duration(seconds: 8);

  final SomunIncomingFunctionHandler _incomingFunctionHandler;
  final Function onDisconnect;

  Socket? _socket;
  StreamSubscription<Uint8List>? _socketSubscription;
  bool _forceDisconnected = false;

  SomunConnection(this._incomingFunctionHandler, this.onDisconnect);

  Future connect(String hostAddr, int port) async {

    SomunIncomingPacketBuilder builder = SomunIncomingPacketBuilder();

    builder.onPacket((packet) {
      if (_forceDisconnected) {
        return;
      }
      IncomingFunctionParser(packet).parse((functionName, params){        
        _incomingFunctionHandler.incomingFunction(functionName, params);
      });
    });

    try {

      _socket = await Socket.connect(hostAddr, port, timeout: defaultConnectionTimeout);

      if (_forceDisconnected) {
        _socket?.destroy();
        _socket = null;
        return;
      }

    }
    catch (exception) {
      print("Somun socket exception: $exception");
      if (_forceDisconnected) {
        return;
      }
      onDisconnect.call();
      return;
    }
    
    _socketSubscription = _socket!.listen((data) {
      builder.addData(data);
    });

    _socketSubscription?.onDone(() {
      print("Somun SOCKET SUBSCRIPTION DONE [disconnected]");
      if (_forceDisconnected) {
        return;
      }
      onDisconnect.call();
    });

    _socketSubscription?.onError((error){
      print("Somun SOCKET SUBSCRIPTION ERROR: $error");
    });

  }

  void call(String functionName, List params) {

    print("Calling Function: $functionName $params");

    final OutgoingPacketBuilder builder = OutgoingPacketBuilder(functionName);
    
    for (final v in params) {

      if (v is int) {
        builder.pushIntParam(v);
      }
      else if (v is String) {
        builder.pushStringParam(v);
      }
      else if (v is List<String>) {
        builder.pushStringListParam(v);
      }
      else if (v is List<int>) {
        builder.pushIntListParam(v);
      }
      else {
        throw Exception("Somun SomunClient.call parameter type not implemented for $functionName");
      }

    }

    if (isConnected()) {
      _socket!.add(builder.build());
    }
    else {
      print("Somun Can not call function! Socket not connected $functionName");
    }

  }

  void disconnect() {

    if (_forceDisconnected) {
      return;
    }
    _forceDisconnected = true;

    if (isConnected()) {
      _socket?.destroy();      // this cancels any inprogress reads & writes
      _socket = null;      
    }

  }

  bool isConnected() => _socket != null;

}


class IncomingFunctionParser {

  late ReadBuffer _buffer;

  IncomingFunctionParser(SomunPacket packet) {
    _buffer = ReadBuffer(packet.data.buffer);
  }

  void parse(void Function(String, List) callback) {

    String functionName = _buffer.readJavaString();
    int paramCount = _buffer.readUByte();

    List params = [];

    for (int i=0;i<paramCount;++i) {
      int paramType = _buffer.readUByte();
      params.add(_popParam(paramType));
    }

    callback(functionName, params);

  }

  dynamic _popParam(int paramType) {
    if (paramType == BYTE_PARAM_TYPE) {
      return _buffer.readByte();
    }
    else if (paramType == INT_PARAM_TYPE) {
      return _buffer.readInt();
    }
    else if (paramType == LONG_PARAM_TYPE) {
      return _buffer.readLong();
    }
    else if (paramType == STRING_PARAM_TYPE) {
      return _buffer.readJavaString();
    }
    else if (paramType == ARRAY_PARAM_TYPE) {
      
      int length = _buffer.readInt();
      int type = _buffer.readUByte();
      List arrayParams = [];

      for (int i=0;i<length;++i) {
        arrayParams.add(_popParam(type));
      }

      return arrayParams;
    }
  }

}

abstract class SomunIncomingFunctionHandler {
  void incomingFunction(String functionName, List params);
}