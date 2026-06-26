import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screens/auth/login_page.dart';
import '../../screens/auth/register_page.dart';
import '../../screens/exam/exam_page.dart';
import '../../screens/exam/simulacro_page.dart';
import '../../screens/splash/splash_screen.dart';
import 'route_paths.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RoutePaths.simulacro,
        name: 'simulacro',
        builder: (context, state) => const SimulacroPage(),
      ),
      GoRoute(
        path: '${RoutePaths.exam}/:studentExamId',
        name: 'exam',
        builder: (context, state) {
          final studentExamId = int.parse(state.pathParameters['studentExamId']!);
          return ExamPage(studentExamId: studentExamId);
        },
      ),
    ],
  );
});
