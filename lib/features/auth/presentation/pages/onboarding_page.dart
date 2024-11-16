import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      const CustomText(
                        "¡Bienvenido a TASK APP!",
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                          "Lleva el control de tus tareas al siguiente nivel de manera fácil, rápida y eficiente.\n\nRegístrate ahora y empieza a organizarte mejor."),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(colors.primaryColor)),
                          onPressed: () => context.go(Routes.register),
                          child: const CustomText(
                            "Registrarse",
                            fontWeight: FontWeight.bold,
                            textColor: Colors.white,
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
