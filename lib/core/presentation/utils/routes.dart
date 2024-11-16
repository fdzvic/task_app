import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/features/auth/presentation/pages/init_page.dart';
import 'package:taks_app/features/auth/presentation/pages/onboarding_page.dart';
import 'package:taks_app/features/auth/presentation/pages/register_page.dart';
import 'package:taks_app/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:taks_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:taks_app/features/settings/presentation/pages/settings_page.dart';
import 'package:taks_app/features/tasks/presentation/pages/tasks_details_page.dart';

class Routes {
  static const String init = '/';
  static const String onBoarding = '/onboarding';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String detailsTask = '/details-task';
  static const String notification = '/notifications';
  static const String settings = '/settings';
}

final router = GoRouter(initialLocation: Routes.init, routes: [
  GoRoute(
      path: Routes.init,
      pageBuilder: (context, state) =>
          page(state: state, child: const InitPage())),
  GoRoute(
      path: Routes.onBoarding,
      pageBuilder: (context, state) =>
          page(state: state, child: const OnboardingPage())),
  GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) =>
          page(state: state, child: const RegisterPage())),
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
  GoRoute(
      path: Routes.notification,
      pageBuilder: (context, state) =>
          page(state: state, child: const NotificationsPage())),
  GoRoute(
      path: Routes.settings,
      pageBuilder: (context, state) =>
          page(state: state, child: const SettingsPage())),
]);

NoTransitionPage<void> page(
        {required GoRouterState state, required Widget child}) =>
    NoTransitionPage<void>(key: state.pageKey, child: child);
