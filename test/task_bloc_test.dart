import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/add_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/complete_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:taks_app/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_state.dart';

import 'task_bloc_test.mocks.dart';

// Genera los mocks
@GenerateMocks([GetTasks, AddTask, DeleteTask, CompleteTask])
void main() {
  late MockGetTasks mockGetTasks;
  late MockAddTask mockAddTask;
  late MockDeleteTask mockDeleteTask;
  late MockCompleteTask mockCompleteTask;
  late TaskBloc taskBloc;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTask();
    mockDeleteTask = MockDeleteTask();
    mockCompleteTask = MockCompleteTask();

    taskBloc = TaskBloc(
      getTasks: mockGetTasks,
      addTask: mockAddTask,
      deleteTask: mockDeleteTask,
      completeTask: mockCompleteTask,
    );
  });

  tearDown(() {
    taskBloc.close();
  });

  group('TaskBloc', () {
    test('initial state is TaskLoading', () {
      expect(taskBloc.state, TaskLoading());
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when LoadTasks is added',
      build: () {
        // Configura el mock para getTasks
        when(mockGetTasks()).thenAnswer((_) async => [
              const Task(id: '1', title: 'Test Task 1', isCompleted: false),
            ]);
        return taskBloc;
      },
      act: (bloc) => bloc.add(LoadTasks()),
      expect: () => [
        TaskLoading(),
        const TaskLoaded([
          Task(id: '1', title: 'Test Task 1', isCompleted: false),
        ]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when AddTaskEvent is added',
      build: () {
        // Configura los mocks para addTask y getTasks
        when(mockAddTask(any)).thenAnswer((_) async => Future.value());
        when(mockGetTasks()).thenAnswer((_) async => [
              const Task(id: '1', title: 'Test Task 1', isCompleted: false),
              const Task(id: '2', title: 'New Task', isCompleted: false),
            ]);
        return taskBloc;
      },
      act: (bloc) => bloc.add(AddTaskEvent(
          task: const Task(
        date: "",
        description: "",
        id: '2',
        title: 'New Task',
        isCompleted: false,
      ))), // Crea una instancia de Task en lugar de pasar solo el título
      expect: () => [
        TaskLoading(),
        const TaskLoaded([
          Task(id: '1', title: 'Test Task 1', isCompleted: false),
          Task(id: '2', title: 'New Task', isCompleted: false),
        ]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskLoaded] when DeleteTaskEvent is added',
      build: () {
        // Configura el mock para deleteTask para que responda correctamente
        when(mockDeleteTask(any)).thenAnswer((_) async => Future.value());

        // Configura el mock para getTasks para que devuelva una lista vacía después de la eliminación
        when(mockGetTasks()).thenAnswer((_) async => []);

        return taskBloc;
      },
      act: (bloc) => bloc.add(DeleteTaskEvent(taskId: '1')),
      expect: () => [
        TaskLoading(),
        const TaskLoaded([]), // Ahora la lista esperada coincide con el mock
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when LoadTasks fails',
      build: () {
        // Configura el mock para lanzar una excepción
        when(mockGetTasks()).thenThrow(Exception('Failed to load tasks'));
        return taskBloc;
      },
      act: (bloc) => bloc.add(LoadTasks()),
      expect: () => [
        TaskLoading(),
        TaskError(),
      ],
    );
  });
}
