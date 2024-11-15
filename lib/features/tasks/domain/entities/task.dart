import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? date;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.date,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, title, description, date, isCompleted];
}
