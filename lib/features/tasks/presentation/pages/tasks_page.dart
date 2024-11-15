import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/custom_dialogs.dart';
import 'package:taks_app/core/presentation/utils/extension/dimens_extension.dart';
import 'package:taks_app/core/presentation/utils/global/global_data.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
                        width: context.width(.3),
                        child: CustomText(
                          globalData.itemsFilter[index]['label'],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: globalData.itemsFilter.length,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // BlocProvider.of<TaskBloc>(context)
                                  //     .add(DeleteTaskEvent(taskId: task.id));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // BlocProvider.of<TaskBloc>(context)
                                  //     .add(DeleteTaskEvent(taskId: task.id));
                                },
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
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    context.showAddTaskDialog(
      child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Column(
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
                controller: titleController,
                onChanged: (value) {
                  setState(() {}); // Esto actualiza el estado del modal
                },
              ),
              CustomTextFormField(
                label: "Descripción",
                controller: descriptionController,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const CustomText(
                      'Cancelar',
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      'Agregar',
                      textColor: colors.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const CustomText(
    //         'Nueva Tarea',
    //         fontSize: 24,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       content: TextField(
    //         controller: taskController,
    //         decoration: const InputDecoration(
    //             hintText: 'Ingrese el título de la tarea'),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const CustomText('Cancelar'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             final title = taskController.text;
    //             if (title.isNotEmpty) {
    //               BlocProvider.of<TaskBloc>(context).add(
    //                   AddTaskEvent(task: const Task(id: "1", title: "nombre")));
    //             }
    //             Navigator.of(context).pop();
    //           },
    //           child: const CustomText('Agregar'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
