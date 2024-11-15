import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/custom_dialogs.dart';
import 'package:taks_app/core/presentation/utils/extension/dimens_extension.dart';
import 'package:taks_app/core/presentation/utils/global/global_data.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';
import 'package:taks_app/features/tasks/presentation/widgets/add_task_form.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Lista de tareas",
                    styleType: TextStyleType.bodyLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    "Filtrar por",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CustomCard(
                        color: colors.primaryColor,
                        width: context.width(.32),
                        child: CustomText(
                          globalData.itemsFilter[index]['label'],
                          textAlign: TextAlign.center,
                          textColor: Colors.white,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: globalData.itemsFilter.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.only(left: 10),
                          tileColor: index % 2 == 0
                              ? Colors.grey[200]
                              : Colors.white, // Alterna colores
                          selectedTileColor: Colors
                              .blue[100], // Color cuando está seleccionado
                          selected:
                              false, // Cambia esto según tu lógica de selección
                          title: CustomText(task.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle_outlined,
                                  color: task.isCompleted ? Colors.green : null,
                                ),
                                onPressed: () {
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(CompleteTaskEvent(taskId: task.id));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    BlocProvider.of<TaskBloc>(context)
                                        .add(DeleteTaskEvent(taskId: task.id)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.showAddTaskDialog(child: const AddTaskForm()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
