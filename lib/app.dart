import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_app/core/presentation/design/tokens/theme.dart' as t;
import 'package:taks_app/core/presentation/utils/routes.dart';
import 'package:taks_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:taks_app/features/tasks/domain/use_cases/add_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';

class App extends StatelessWidget {
  final TaskRepository taskRepository;
  const App({
    super.key,
    required this.taskRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
            getTasks: GetTasks(taskRepository),
            addTask: AddTask(taskRepository),
            deleteTask: DeleteTask(taskRepository),
          )..add(LoadTasks()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Task_App',
        debugShowCheckedModeBanner: false,
        theme: t.CustomTheme().theme,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
