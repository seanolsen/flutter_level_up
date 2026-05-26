import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app/app_widget.dart';
import 'core/di/injection.dart';
import 'utils/date_helpers.dart';
import 'utils/http_helpers.dart';

const storage = FlutterSecureStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HttpHelpers.updateDefaultUserAgent();
  HttpOverrides.global = _HttpOverrides();
  await ensureDateFormattingInitialized();

  // initialize dependencies injections
  await configureInjection();

  runApp(
    AppWidget(),
  );
}

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent = HttpHelpers.getDefaultUserAgent();
  }
}
