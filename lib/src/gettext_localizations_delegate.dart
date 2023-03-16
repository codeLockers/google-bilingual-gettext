import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gettext_localizations.dart';

class GettextLocalizationsDelegate
    extends LocalizationsDelegate<GettextLocalizations> {
  GettextLocalizationsDelegate(this.sourcePath, {this.defaultLanguage = 'en'});

  final String defaultLanguage;
  final String sourcePath;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<GettextLocalizations> load(Locale locale) async {
    var poContent = '';
    try {
      poContent = await rootBundle.loadString(
          '$sourcePath/${locale.languageCode.toLowerCase()}_${locale.countryCode?.toLowerCase()}.po');
    } catch (e) {
      try {
        poContent = await rootBundle
            .loadString('$sourcePath/${locale.languageCode.toLowerCase()}.po');
      } catch (e) {
        try {
          poContent =
              await rootBundle.loadString('$sourcePath/$defaultLanguage.po');
        } catch (e) {
          // Ignore error, default strings will be used.
        }
      }
    }

    if (poContent == '') {
      poContent = 'msgid ""\nmsgstr ""\n"Language: $defaultLanguage\\n"\n';
    }

    return GettextLocalizations.fromPO(poContent);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<GettextLocalizations> old) =>
      true;
}
