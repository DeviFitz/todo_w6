import '../model/task.dart';
import '../services/local_storage.dart';
import '../services/storage.dart';

//The purpose of this file is to command the behavior of tasks. 
//That includes adding and removing tasks

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  final Storage _storage = LocalStorage();

  Stream<List<Task>> getStream() => _storage.getTasks();

  Future<void> insertTask(String description) =>
      _storage.insertTask(description);

  Future<void> removeTask(Task task) => _storage.removeTask(task);

  Future<void> initialize() => _storage.initialize();
}
