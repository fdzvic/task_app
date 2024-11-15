import 'package:taks_app/features/tasks/data/data_sources/tasks_data_source.dart';
import 'package:taks_app/features/tasks/data/models/task_model.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TasksDataSource taskListDataSource;

  TaskRepositoryImpl(this.taskListDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await taskListDataSource.getTasks();
    return taskModels
        .map((taskModel) => Task(
              id: taskModel.id,
              title: taskModel.title,
              isCompleted: taskModel.isCompleted,
            ))
        .toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
    await taskListDataSource.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await taskListDataSource.deleteTask(taskId);
  }
}
