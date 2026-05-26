
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sprintf/sprintf.dart';

import '../app/constants.dart';

class HttpHelpers {
  static String normalizeAssetUrl(String url) {
    if (url.startsWith('https://')) {
      return url;
    } else {
      return Constants.apiHostUrl + url;
    }
  }
  
  static CookieJar cookieJar = CookieJar();

  static String _userAgent = '';

  static Future<void> updateDefaultUserAgent() async {
    if (_userAgent.isEmpty) {
      final String platformName = '${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
      final String userAgentTemplate = 'Mozilla/5.0 (%s-app/%s/build:%s $platformName) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';
      try {
        final packageInfo = await PackageInfo.fromPlatform();
        _userAgent = sprintf(userAgentTemplate, [packageInfo.appName, packageInfo.version, packageInfo.buildNumber]);
      } on Exception catch (_) {
        _userAgent = sprintf(userAgentTemplate, ['mobile', '0', '0']);
      }
    }
  }

  static String getDefaultUserAgent() {
    return _userAgent;
  }

  static Dio getDioClient() {
    final dio =  Dio(BaseOptions(
      baseUrl: Constants.apiHostUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'User-Agent': getDefaultUserAgent(),
        'X-App-In-Use': Platform.isIOS ? 'ios_app' : 'android_app',
      },
    ));
    // final cookieJar = PersistCookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    // dio.addSentry();

    return dio;
  }

  static Future<List<Cookie>> getCookies() {
    return cookieJar.loadForRequest(Uri.parse(Constants.apiHostUrl));
  }

  static Future<void> setCookies(List<Cookie> cookies) async {
    await cookieJar.saveFromResponse(
      Uri.parse(Constants.apiHostUrl),
      cookies,
    );
  }

  static Future<void> addCookies(List<Cookie> newCookies) async {
    List<Cookie> cookies = await getCookies();
    cookies.addAll(newCookies);
    await setCookies(cookies);
  }
}
