import 'package:blinkit_admin/features/auth/presentation/pages/forget_password/forget_password_page.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/login/login_page.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/signup/signup_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/fp',
      name: 'fp',
      builder: (context, state) => const ForgetPasswordPage(),
    ),
  ],
);
