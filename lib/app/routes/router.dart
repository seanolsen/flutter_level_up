import 'package:auto_route/auto_route.dart';

import '../screens/chats.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ChatsRoute.page, initial: true),
  ];
}
