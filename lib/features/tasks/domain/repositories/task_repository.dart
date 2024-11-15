import 'package:taks_app/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> completeTask(String taskId);
}
