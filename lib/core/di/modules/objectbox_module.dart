import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../objectbox.g.dart';

@module
abstract class ObjectBoxModule {
  @preResolve
  @singleton
  Future<Store> store() async {
    final docDir = await getApplicationDocumentsDirectory();
    return openStore(directory: p.join(docDir.path, 'objectbox'));
  }
}
