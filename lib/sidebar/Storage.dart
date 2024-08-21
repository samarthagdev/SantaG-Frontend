import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
var ui;
SecureStorage({this.ui});

final _storage = FlutterSecureStorage();

  Future writeSecureData(String _key, String _value) async {
    var writedata = await _storage.write(key: _key, value: _value);
    return writedata;
  }

  Future readSecureData(String _key) async {
    var readdata = await _storage.read(key: _key);
    return readdata;
  }

  Future deleteSecureData(String _key) async {
    var deletedata = await _storage.delete(key: _key);
    return deletedata;
  }


  Future readallSecureData() async {
    var readalldata = await _storage.readAll();
    return readalldata;
  }

  Future deleteallSecureData() async {
    var deletealldata = await _storage.deleteAll();
    return deletealldata;
  }

}