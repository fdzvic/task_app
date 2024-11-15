import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    await repository.addTask(task);
  }
}
