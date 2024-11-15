import 'package:taks_app/features/tasks/domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;
  DeleteTaskEvent({required this.taskId});
}

class CompleteTaskEvent extends TaskEvent {
  final String taskId;
  CompleteTaskEvent({required this.taskId});
}
