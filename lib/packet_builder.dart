import 'dart:io';
import 'dart:typed_data';

import 'write_buffer.dart';
import 'somun_param_types.dart';

class SomunPacket {
  
  Uint8List data;
  
  SomunPacket(this.data);

}

class SomunIncomingPacketBuilder {

  final BytesBuilder _builder = BytesBuilder();
  late void Function(SomunPacket) _onPacket;

  void addData(Uint8List data) {

    _builder.add(data);

    if (_builder.length < 4) {
      // not enough data to read packet length. Skip till next frame.
      return;
    }

    Uint8List bytes = _builder.takeBytes();

    int packetLength = bytes[3] + (bytes[2] << 8) + (bytes[1] << 16) + (bytes[0] << 24);

    if (bytes.length < packetLength + 4) {

      // not enough data to construct a packet.
      // push back data and wait till next frame.

      _builder.add(bytes);
      return;

    }
    
    Uint8List currentPacket = bytes.sublist(4, packetLength+4);  // skip packet length
    Uint8List remainingData = bytes.sublist(packetLength + 4);
    
    _onPacket(SomunPacket(currentPacket));

    if (remainingData.isNotEmpty) {
      addData(remainingData);
    }

  }

  void onPacket(void Function(SomunPacket) onPacket) {
    _onPacket = onPacket;
  }

}

class OutgoingPacketBuilder {

  late WriteBuffer _buffer;
  ByteData get data => _buffer.data;

  late int _paramCountOffset;
  int _paramCount = 0;

  OutgoingPacketBuilder(String name) {

    _buffer = WriteBuffer();
    _buffer.writeInt(0);  // reserved for packet length
    _buffer.writeJavaString(name);
    _buffer.writeByte(0);  // reserved for parameter count

    _paramCountOffset = _buffer.currentOffset - 1;

  }

  Uint8List build() {
    
    // fill-in packet length    
    _buffer.writeIntAt(0, _buffer.currentOffset-4);
    
    // fill-in parameter count
    _buffer.writeUByteAt(_paramCountOffset, _paramCount);

    return data.buffer.asUint8List(0, _buffer.currentOffset);
  }

  void _pushParamType(int paramType) {
    _buffer.writeUByte(paramType);
    _paramCount++;
  }

  void pushByteParam(int value) {
    _pushParamType(BYTE_PARAM_TYPE);
    _buffer.writeByte(value);    
  }

  void pushIntParam(int value) {
    _pushParamType(INT_PARAM_TYPE);
    _buffer.writeInt(value);    
  }

  void pushLongParam(int value) {
    _pushParamType(LONG_PARAM_TYPE);
    _buffer.writeLong(value);    
  }

  void pushStringParam(String value) {
    _pushParamType(STRING_PARAM_TYPE);
    _buffer.writeJavaString(value);
  }

  void pushIntListParam(List<int> values) {
    _pushParamType(ARRAY_PARAM_TYPE);
    _buffer.writeInt(values.length);
    _buffer.writeUByte(INT_PARAM_TYPE);
    for (final v in values) {
      _buffer.writeInt(v);
    }        
  }

  void pushStringListParam(List<String> values) {
    _pushParamType(ARRAY_PARAM_TYPE);
    _buffer.writeInt(values.length);
    _buffer.writeUByte(STRING_PARAM_TYPE);
    for (final v in values) {
      _buffer.writeJavaString(v);
    }        
  }

}
