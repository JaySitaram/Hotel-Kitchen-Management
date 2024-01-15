import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static const String email = 'email';
  static const String password = 'password';
  static const String userRole = 'userRole';

  static const String lanCode = 'languageCode';

  static writeStorage(var key, var value) {
    GetStorage().write(key, value);
  }

  static readStorage(var key) {
    return GetStorage().read(key);
  }

  static removeStorage(var key) {
    GetStorage().remove(key);
  }

  static eraseStorage() {
    GetStorage().erase();
  }
}
