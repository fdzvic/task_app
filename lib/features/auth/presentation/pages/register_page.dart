import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/data/network/user_preferences.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';
import 'package:taks_app/features/auth/domain/entities/user_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(debugLabel: '_registerFormKey');
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
                  child: Form(
                    key: formkey,
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
                        CustomTextFormField(
                          label: "Nombres",
                          controller: tecName,
                        ),
                        CustomTextFormField(
                          label: "Apellidos",
                          controller: tecLastName,
                        ),
                        CustomTextFormField(
                          label: "Email",
                          controller: tecEmail,
                          inputValueType: InputValueType.email,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    colors.primaryColor)),
                            onPressed: () async => toRegister(context),
                            child: const CustomText(
                              "Registrarse",
                              fontWeight: FontWeight.bold,
                              textColor: Colors.white,
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> toRegister(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      prefs.userData = json.encode(UserData(
              name: tecName.text,
              lastName: tecLastName.text,
              email: tecEmail.text,
              createdAt: DateTime.now().toIso8601String())
          .toJson());

      if (!context.mounted) return;
      context.go(Routes.dashboard);
    }
  }
}
