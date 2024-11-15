import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/custom_dialogs.dart';
import 'package:taks_app/core/presentation/utils/global/global_data.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';
import 'package:taks_app/features/tasks/presentation/widgets/add_task_form.dart';
import 'package:taks_app/features/tasks/presentation/widgets/list_task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            idFilter = index;
                          });
                        },
                        child: CustomCard(
                          color: colors.primaryColor,
                          child: CustomText(
                            "${globalData.itemsFilter[index]['label']} (${getListLength(index)})",
                            textAlign: TextAlign.center,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: globalData.itemsFilter.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTask(
                    listTask: getList(),
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

  int getListLength(int index) {
    if (index == 0) return allTasks.length;
    if (index == 1) return noCompletedTasks.length;
    if (index == 2) return completedTasks.length;
    return 0;
  }

  List<Task> getList() {
    if (idFilter == 0) return allTasks;
    if (idFilter == 1) return noCompletedTasks;
    if (idFilter == 2) return completedTasks;
    return [];
  }
}
