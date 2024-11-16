import 'package:flutter/widgets.dart';
import 'package:taks_app/app.dart';
import 'package:taks_app/core/data/network/app_storage.dart';
import 'package:taks_app/core/data/network/user_preferences.dart';
import 'package:taks_app/features/tasks/data/data_sources/tasks_data_source.dart';
import 'package:taks_app/features/tasks/data/repositories/task_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await prefs.initPrefs();
  final appStorage = AppStorage(sharedPreferences: sharedPreferences);
  final taskListDataSource = TasksDataSource(appStorage);
  final taskRepository = TaskRepositoryImpl(taskListDataSource);

  runApp(App(taskRepository: taskRepository));
}
