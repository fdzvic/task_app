import 'package:taks_app/features/tasks/data/data_sources/tasks_data_source.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TasksDataSource tasksDataSource;

  TaskRepositoryImpl(this.tasksDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await tasksDataSource.getTasks();
    return taskModels
        .map((taskModel) => Task(
              id: taskModel.id,
              title: taskModel.title,
              isCompleted: taskModel.isCompleted,
              date: taskModel.date,
              description: taskModel.description,
            ))
        .toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = Task(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
      date: task.date,
      description: task.description,
    );
    await tasksDataSource.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await tasksDataSource.deleteTask(taskId);
  }

  @override
  Future<void> completeTask(String taskId) async {
    await tasksDataSource.completeTask(taskId);
  }
}
