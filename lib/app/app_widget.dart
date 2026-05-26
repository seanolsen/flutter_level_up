
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/data/async/i_transport.dart';
import '../core/di/injection.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import 'routes/router.dart';

class AppWidget extends StatelessWidget {
  AppWidget({
    super.key,
  });

  final _appRouter = AppRouter(
    // authGuard: getIt<AuthGuard>(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (p, c) => p.authStatus != c.authStatus,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.authenticated) {
            state.authenticatedCustomerConfigOption.fold(
              () => null,
              (authenticatedCustomerConfig) {
                getIt<IAsyncCommandsTransport>().connect(
                  privateChannelId: authenticatedCustomerConfig.websocket.getPrivateChannelIdOrCrash(),
                  publicChannelId: authenticatedCustomerConfig.websocket.getPublicChannelIdOrCrash(),
                );
              },
            );
          } else if (state.authStatus == AuthStatus.unauthenticated) {
            getIt<IAsyncCommandsTransport>().disconnect();
          }
        },
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
        ),
      ),
    );
  }
}
