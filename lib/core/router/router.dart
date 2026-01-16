import 'package:go_router/go_router.dart';

import '/features/auth/presentation/screens/login_screen.dart';
import '/features/auth/presentation/screens/register_screen.dart';
import '/features/main/data/models/image_model.dart';
import '/features/main/presentation/screens/main_screen.dart';
import '/features/painter/presentation/screens/painter_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: '/login',
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
    GoRoute(
      path: '/painter',
      builder: (context, state) {
        final props = state.extra as ImageModel?;
        return PainterScreen(imageModel: props);
      },
    ),
  ],
);
