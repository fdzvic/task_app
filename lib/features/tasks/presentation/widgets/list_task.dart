import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';

class ListTask extends StatelessWidget {
  const ListTask({
    super.key,
    required this.listTask,
  });

  final List<Task> listTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listTask.length,
        itemBuilder: (context, index) {
          final task = listTask[index];
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 10),
            tileColor: index % 2 == 0 ? Colors.grey[200] : Colors.white,
            selectedTileColor: Colors.blue[100],
            title: CustomText(task.title),
            onTap: () =>
                context.go(Routes.detailsTask, extra: {"data": task.toJson()}),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.check_circle_outlined,
                    color: task.isCompleted ? Colors.green : null,
                  ),
                  onPressed: () {
                    BlocProvider.of<TaskBloc>(context)
                        .add(CompleteTaskEvent(taskId: task.id));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => BlocProvider.of<TaskBloc>(context)
                      .add(DeleteTaskEvent(taskId: task.id)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
