import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController tecTitle = TextEditingController();
  final TextEditingController tecDescription = TextEditingController();
  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(debugLabel: '_addTaskFormKey');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Nueva Tarea',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: "Título",
            controller: tecTitle,
            onChanged: (value) => formkey.currentState!.validate(),
          ),
          CustomTextFormField(
            label: "Descripción (opcional)",
            controller: tecDescription,
            inputValueType: InputValueType.paragraph,
            onChanged: (value) {
              setState(() {}); // Esto actualiza el estado del modal
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red)),
                onPressed: () => Navigator.of(context).pop(),
                child: const CustomText('Cancelar', textColor: Colors.white),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => addTask(context),
                child: CustomText('Agregar', textColor: colors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  void addTask(BuildContext context) {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<TaskBloc>(context).add(
        AddTaskEvent(
          task: Task(
            id: generateUniqueId(),
            title: tecTitle.text,
            description: tecDescription.text,
            date: DateTime.now().toIso8601String(),
          ),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  String generateUniqueId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(100000); // Número aleatorio
    return '$now-$random'; // Combina marca de tiempo y número aleatorio
  }
}
