import 'package:flutter/material.dart';
import 'package:taks_app/features/home/presentation/widgets/custom_card_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomCardTask(
              title: "Tareas pendientes",
            ),
            SizedBox(height: 20),
            CustomCardTask(title: "Tareas finalizadas"),
          ],
        ),
      ),
    );
  }
}
