import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late bool isFirstRun;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      isFirstRun = await IsFirstRun.isFirstRun();
    });

    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    Timer(const Duration(seconds: 5), () {
      context.go(Routes.onBoarding);
      // isFirstRun ? prefs.usersRegistered = json.encode(mockUsers) : null;
      // prefs.loggedIn ? context.go(Routes.home) : context.go(Routes.login);
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryColor,
      body: SafeArea(
          child: Center(
              child: AnimatedBuilder(
        animation: _animatedController,
        builder: (context, child) {
          return AnimatedOpacity(
              opacity: _animatedController.value < 0.5 ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: const CustomText(
                "Cargando...",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
              ));
        },
      ))),
    );
  }
}
