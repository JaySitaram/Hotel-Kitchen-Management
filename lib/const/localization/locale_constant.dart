import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';

var supportedLocales = [
  Locale(AppLanguagesEnum.en.key ?? ""),
  Locale(AppLanguagesEnum.ar.key ?? ""),
];

Locale setLocale(String languageCode) {
  LocalStorage.writeStorage(LocalStorage.lanCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  return _locale(LocalStorage.readStorage(LocalStorage.lanCode));
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode)
      : Locale(AppLanguagesEnum.ar.key ?? "");
}

// void changeLanguage(BuildContext context, String selectedLanguageCode) {
//   var locale = setLocale(selectedLanguageCode);
//   MyApp.setLocale(context, locale);
// }

enum AppLanguagesEnum { en, ar }

extension AppLanguagesEnumStatusExt on AppLanguagesEnum {
  static const Map<AppLanguagesEnum, String> keys = {
    AppLanguagesEnum.en: 'en',
    AppLanguagesEnum.ar: 'ar',
  };

  static const Map<AppLanguagesEnum, String> values = {
    AppLanguagesEnum.en: 'English',
    AppLanguagesEnum.ar: 'Arabic',
  };

  String? get key => keys[this];

  String? get value => values[this];

  // NEW
  static AppLanguagesEnum? fromRaw(String raw) =>
      keys.entries.firstWhere((e) => e.value == raw).key;
}
