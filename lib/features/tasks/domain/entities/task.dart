import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? date;
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

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
