import 'package:flutter/material.dart';
import 'gettext_localizations.dart';

extension ContextExt on BuildContext {
  String t(String msgid, {String? msgctxt, List<Object>? args}) =>
      GettextLocalizations.of(this).t(msgid, msgctxt ?? '', args);
}
