import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        "Registro",
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      const CustomTextFormField(
                        label: "Nombres",
                      ),
                      const CustomTextFormField(
                        label: "Apellidos",
                      ),
                      const CustomTextFormField(
                        label: "Email",
                      ),
                      const CustomTextFormField(
                        label: "Crea un PIN de 4 números",
                      ),
                      const CustomTextFormField(
                        label: "Confirma tu PIN",
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(colors.primaryColor)),
                          onPressed: () => context.go(Routes.dashboard),
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
