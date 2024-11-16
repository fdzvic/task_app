import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Task> allTasks = [];
  List<Task> completedTasks = [];
  List<Task> noCompletedTasks = [];
  int idFilter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            allTasks = state.tasks;
            completedTasks =
                allTasks.where((task) => task.isCompleted).toList();
            noCompletedTasks =
                allTasks.where((task) => !task.isCompleted).toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Mi perfil",
                    styleType: TextStyleType.bodyLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is TaskError) {
            return const Center(child: CustomText('Error al cargar tareas'));
          } else {
            return const Center(child: CustomText('No hay tareas disponibles'));
          }
        },
      ),
    );
  }
}
