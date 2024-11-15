import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/features/tasks/domain/use_cases/add_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
  }) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading()); // Asegura que TaskLoading se emita primero
      try {
        final tasks = await getTasks();
        emit(TaskLoaded(tasks));
      } catch (_) {
        emit(TaskError());
      }
    });

    on<AddTaskEvent>((event, emit) async {
      await addTask(event.task);
      add(LoadTasks()); // Recarga las tareas después de agregar
    });

    on<DeleteTaskEvent>((event, emit) async {
      await deleteTask(event.taskId);
      add(LoadTasks()); // Recarga las tareas después de eliminar
    });
  }
}
