import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_bloc.dart';
import 'package:taks_app/features/tasks/presentation/blocs/task_event.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.information});
  final Map information;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late List<Map<String, dynamic>> listData;

  @override
  void initState() {
    super.initState();
    listData = [];
    if (widget.information.containsKey('data')) {
      final data = widget.information['data'] as Map<String, dynamic>;
      listData = data.entries.map((entry) {
        return {
          'label': entry.key,
          'value': entry.value,
        };
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "Detalles",
          fontSize: 24,
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.go(Routes.dashboard),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomCard(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        "Información",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                        },
                        children: listData.isNotEmpty
                            ? List<TableRow>.generate(
                                listData.length * 2 - 1,
                                (index) {
                                  if (index.isOdd) {
                                    return TableRow(
                                      children: List.generate(
                                        2,
                                        (colIndex) =>
                                            const SizedBox(height: 10),
                                      ),
                                    );
                                  } else {
                                    final data = listData[index ~/ 2];
                                    return TableRow(
                                      decoration: BoxDecoration(
                                        color:
                                            colors.primaryColor.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                            getTitle(data["label"]),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            getValue(data["label"].toString(),
                                                data["value"].toString()),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              )
                            : [
                                const TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "No hay datos disponibles",
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.red)),
                              onPressed: () {
                                BlocProvider.of<TaskBloc>(context).add(
                                  DeleteTaskEvent(
                                    taskId: widget.information['data']['id'],
                                  ),
                                );
                                context.go(Routes.dashboard);
                              },
                              child: const CustomText(
                                "Eliminar",
                                textColor: Colors.white,
                              )),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<TaskBloc>(context).add(
                                  CompleteTaskEvent(
                                    taskId: widget.information['data']['id'],
                                  ),
                                );
                                context.go(Routes.dashboard);
                              },
                              child: CustomText(widget.information['data']
                                      ['isCompleted']
                                  ? "Reactivar"
                                  : "Finalizar")),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getValue(String key, String value) {
    if (key == 'createdAt') {
      return DateTime.parse(value).toString().split(' ').first;
    }
    if (key == 'isCompleted') {
      return value == 'true' ? 'Completada' : 'Pendiente';
    }
    return value;
  }

  getTitle(String value) {
    switch (value) {
      case 'id':
        return 'ID';
      case 'title':
        return 'Titulo';
      case 'description':
        return 'Descripción';
      case 'date':
        return 'Fecha';
      case 'isCompleted':
        return 'Estado';

      default:
    }
  }
}
