import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';

class CompleteTask {
  final TaskRepository repository;

  CompleteTask(this.repository);

  Future<void> call(String taskId) async {
    await repository.completeTask(taskId);
  }
}
