import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/features/dashboard/presentation/page/dashboard_page.dart';

class Routes {
  static const String dashboard = '/dashboard';
}

final router = GoRouter(initialLocation: Routes.dashboard, routes: [
  GoRoute(
      path: Routes.dashboard,
      pageBuilder: (context, state) => page(
          state: state,
          child: const DashboardPage(
            userName: "Victor",
          ))),
]);

NoTransitionPage<void> page(
        {required GoRouterState state, required Widget child}) =>
    NoTransitionPage<void>(key: state.pageKey, child: child);
