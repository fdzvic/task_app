import 'package:taks_app/core/data/network/app_storage.dart';
import 'dart:convert';

import 'package:taks_app/features/tasks/data/models/task_model.dart';

class TasksDataSource {
  final AppStorage appStorage;
  static const String tasksKey = 'tasks';

  TasksDataSource(this.appStorage);

  // Método para recuperar la lista de tareas
  Future<List<TaskModel>> getTasks() async {
    final jsonString = appStorage.getData(tasksKey);
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((jsonTask) => TaskModel.fromJson(jsonTask)).toList();
    }
    return [];
  }

  // Método para guardar la lista de tareas
  Future<void> saveTasks(List<TaskModel> tasks) async {
    List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();
    await appStorage.saveData(tasksKey, json.encode(jsonList));
  }

  // Método para agregar una tarea
  Future<void> addTask(TaskModel task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  // Método para eliminar una tarea
  Future<void> deleteTask(String taskId) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await saveTasks(tasks);
  }

  Future<void> completeTask(String taskId) async {
    final tasks = await getTasks();
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      tasks[taskIndex] =
          tasks[taskIndex].copyWith(isCompleted: !tasks[taskIndex].isCompleted);
      await saveTasks(tasks);
    }
  }
}
