import 'dart:convert';
import 'dart:typed_data';

class WriteBuffer {

  final Endian endian = Endian.big;
  static const int maxLength = 1024*16;

  final ByteData _data;
  int _offset = 0;

  int get currentOffset => _offset;
  ByteData get data => _data;

  WriteBuffer() : _data = ByteData(maxLength);

  void writeByte(int value) {
    data.setInt8(_offset++, value);
  }

  void writeUByte(int value) {
    data.setUint8(_offset++, value);
  }

  void writeUInt16(int value) {
    data.setUint16(_offset, value, endian);
    _offset += 2;
  }

  void writeInt(int value) {
    data.setInt32(_offset, value, endian);
    _offset += 4;
  }

  void writeIntAt(int position, int value) {
    data.setInt32(position, value, endian);
  }

  void writeUByteAt(int position, int value) {
    data.setUint8(position, value);
  }

  void writeLong(int value) {
    data.setInt64(_offset, value, endian);
    _offset += 8;
  }

  void writeFloat(double value) {
    data.setFloat32(_offset, value, endian);
    _offset += 4;
  }

  void writeJavaString(String value) {
    List<int> encodedMsg = utf8.encode(value);
    writeUInt16(encodedMsg.length);
    for (var byteCode in encodedMsg) {
      writeUByte(byteCode);
    }    

  }
}
