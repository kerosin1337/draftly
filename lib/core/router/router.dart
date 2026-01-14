import 'package:go_router/go_router.dart';

import '/features/auth/presentation/screens/login_screen.dart';
import '/features/auth/presentation/screens/register_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterScreen();
      },
    ),
  ],
);
