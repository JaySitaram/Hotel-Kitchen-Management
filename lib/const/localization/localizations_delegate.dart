import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/const/localization/language/language_ar.dart';
import 'package:hotel_kitchen_management_flutter/const/localization/locale_constant.dart';

import 'language/language_en.dart';
import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        AppLanguagesEnum.en.key,
        AppLanguagesEnum.ar.key
      ].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    if (locale.languageCode == AppLanguagesEnum.en.key) {
      return AppLocalizationsEn();
    } else if (locale.languageCode == AppLanguagesEnum.ar.key) {
      return AppLocalizationsAr();
    } else {
      // Default language
      return AppLocalizationsAr();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => true;
}
