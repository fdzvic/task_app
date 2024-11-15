import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
