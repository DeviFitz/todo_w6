import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/storage.dart';
import 'dart:async';

// import '../models/task.dart';
// import 'storage.dart';

class LocalStorage implements Storage {
  factory LocalStorage() => _singleton;

  LocalStorage._internal();

  static final LocalStorage _singleton = LocalStorage._internal();
  static const _tasksTable = 'Task';

  late BriteDatabase _database;

  @override
  Future<void> initialize() async {
    final name = join(await getDatabasesPath(), 'todo.db');
    // await deleteDatabase(name);

    final database = await openDatabase(
      name,
      onCreate: _onCreate,
      version: 1,
    );

    _database = BriteDatabase(database);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tasksTable (
        task_id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL
      );
      ''');
    return db.execute('''
      INSERT INTO $_tasksTable (description)
      VALUES ("task 1");
      ''');
  }

  @override
  Stream<List<Task>> getTasks() {
    print('getTasks'); //testing
    return _database.createQuery(_tasksTable).mapToList((e) => Task(
          id: e['task_id'].toString(),
          description: e['description'] as String,
          //description: 'Desc'
        ));
  }

  //Insert new tasks into the database
  @override
  Future<int> insertTask(String description) async {
    return _database.insert(_tasksTable, {'description': description});
  }

  //Remove old tasks from the database 
  @override
  Future<int> removeTask(Task task) async {
    print(task.id);//testing
    return _database.delete(_tasksTable, where: 'task_id = ?', whereArgs: [task.id]);
  }
}
