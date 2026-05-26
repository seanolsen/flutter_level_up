import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/http_helpers.dart';
import '../../../app/constants.dart';

@module
abstract class GraphqlModule {
  @lazySingleton
  GraphQLClient get graphqlClient {
    final Link httpLink = Link.from([
      DioLink(
        '${Constants.apiHostUrl}/graphql',
        client: HttpHelpers.getDioClient(),
        defaultHeaders: {
          // '': ''
        }
      ),
    ]);

    return GraphQLClient(
      // link: authLink.concat(httpLink),
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: InMemoryStore()),
      queryRequestTimeout: const Duration(seconds: 30),
    );
  }
}
