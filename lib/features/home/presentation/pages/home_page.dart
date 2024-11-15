import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/utils/custom_dialogs.dart';
import 'package:taks_app/features/home/presentation/widgets/custom_card_task.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';
import 'package:taks_app/features/tasks/presentation/widgets/add_task_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return state.tasks.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          if (getListTasks(state.tasks, 'not_completed')
                              .isNotEmpty)
                            CustomCardTask(
                              title: "Tareas pendientes",
                              tasks: getListTasks(state.tasks, 'not_completed'),
                            ),
                          const SizedBox(height: 20),
                          if (getListTasks(state.tasks, 'completed').isNotEmpty)
                            CustomCardTask(
                              title: "Tareas finalizadas",
                              tasks: getListTasks(state.tasks, 'completed'),
                            ),
                        ],
                      ),
                    ),
                  )
                : const Center(child: CustomText("No hay tareas registradas"));
          } else if (state is TaskError) {
            return const Center(child: CustomText('Error al cargar tareas'));
          } else {
            return const Center(child: CustomText('No hay tareas disponibles'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.showAddTaskDialog(child: const AddTaskForm()),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Task> getListTasks(List<Task> currentList, String typeList) {
    if (typeList == "completed") {
      return currentList.where((task) => task.isCompleted).toList();
    } else if (typeList == "not_completed") {
      return currentList.where((task) => !task.isCompleted).toList();
    } else {
      return currentList;
    }
  }
}
