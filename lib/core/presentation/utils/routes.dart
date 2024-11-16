import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:taks_app/features/tasks/presentation/pages/tasks_details_page.dart';

class Routes {
  static const String dashboard = '/dashboard';
  static const String detailsTask = '/details-task';
}

final router = GoRouter(initialLocation: Routes.dashboard, routes: [
  GoRoute(
      path: Routes.dashboard,
      pageBuilder: (context, state) => page(
          state: state,
          child: const DashboardPage(
            userName: "Victor",
          ))),
  GoRoute(
      path: Routes.detailsTask,
      pageBuilder: (context, state) => page(
          state: state,
          child: TaskDetailsPage(
            information: state.extra as Map,
          ))),
]);

NoTransitionPage<void> page(
        {required GoRouterState state, required Widget child}) =>
    NoTransitionPage<void>(key: state.pageKey, child: child);
