import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/http_helpers.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    return HttpHelpers.getDioClient();
  }
}
