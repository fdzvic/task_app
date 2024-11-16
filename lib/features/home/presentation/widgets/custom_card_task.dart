import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/utils/extension/dimens_extension.dart';
import 'package:taks_app/core/presentation/utils/routes.dart';
import 'package:taks_app/features/tasks/domain/entities/task.dart';

class CustomCardTask extends StatelessWidget {
  const CustomCardTask({
    super.key,
    required this.title,
    required this.tasks,
  });
  final String title;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            styleType: TextStyleType.bodyLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: context.height(.2),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => context.go(Routes.detailsTask,
                        extra: {'data': tasks[index].toJson()}),
                    child: CustomCard(
                      color: index % 2 == 0
                          ? Colors.grey[200]
                          : Colors.white, // Alterna colores
                      child: CustomText(
                        tasks[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: tasks.length),
          )
        ],
      ),
    );
  }
}
