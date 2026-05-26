import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

bool _dateFormattingInitialized = false;

/// Loads locale data required by [DateFormat.yMd] and similar constructors.
Future<void> ensureDateFormattingInitialized() async {
  if (_dateFormattingInitialized) return;

  final localeTag = ui.PlatformDispatcher.instance.locale.toLanguageTag();
  await initializeDateFormatting(localeTag);
  if (localeTag != 'en') {
    await initializeDateFormatting('en');
  }
  _dateFormattingInitialized = true;
}

String getPlatformDateFormat(BuildContext context) {
  final localeName = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMd(localeName).pattern ?? 'MM/dd/yyyy';
}
