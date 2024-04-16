import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';
import 'storage.dart';

class FirestoreStorage implements Storage {
  static const _tasks = 'tasks';
  static const _description = 'description';

  @override
  Stream<List<Task>> getTasks() {
    //return Stream.empty(); 
       
    //Step 5.b
    return FirebaseFirestore.instance
       .collection(_tasks)
       .snapshots()
       .map((event) => event.docs.map((doc) {
          var description = doc.data()[_description] as String; 
          return Task(description: description, id: doc.id);
       }).toList());
  }

  @override
  Future<void> insertTask(String description) async {
    //return Future.value();
    await FirebaseFirestore.instance.collection(_tasks).add({
      'description': description,
    });
  }

  @override
  Future<void> removeTask(Task task) async {
    await FirebaseFirestore.instance.collection(_tasks).doc(task.id).delete();
  }

  @override
  Future<void> initialize() => Future.value();
}
