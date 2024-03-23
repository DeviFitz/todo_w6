// models/task.dart
//The purpose of this file is to provide the desc and completion status of a task

import 'package:uuid/uuid.dart';

class Task {
  Task({
    required this.description,
    this.isCompleted = false,
    String? id,
  }) : id = id ?? _uuid.v1();

  bool isCompleted;
  final String description;
  final String id;

  static const _uuid = Uuid();

}
