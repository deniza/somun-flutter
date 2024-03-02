import 'dart:convert';
import 'dart:typed_data';

class ReadBuffer {
  
  final Endian endian = Endian.big;
  
  final ByteData _data;
  int _offset = 0;

  ByteData get data => _data;

  ReadBuffer(ByteBuffer buffer) : _data = ByteData.view(buffer);

  int readByte() {
    return data.getInt8(_offset++);
  }

  int readUByte() {
    return data.getUint8(_offset++);
  }

  int readUInt16() {
    int value = data.getUint16(_offset, endian);
    _offset += 2;
    return value;
  }

  int readInt() {
    int value = data.getInt32(_offset, endian);
    _offset += 4;
    return value;
  }

  int readLong() {
    int value = data.getInt64(_offset, endian);
    _offset += 8;
    return value;
  }

  double readFloat() {
    double value = data.getFloat32(_offset, endian);
    _offset += 4;
    return value;
  }

  String readJavaString() {

    int length = readUInt16();    
    List<int> codeUnits = [];

    for (int i=0;i<length;++i) {
      codeUnits.add(readUByte());
    }

    return utf8.decode(codeUnits);
  }

}