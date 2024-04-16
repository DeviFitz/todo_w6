import 'package:flutter/material.dart';
import 'package:todo_app/pages/new_task_page.dart';
import '../controllers/task_controller.dart';
import '../model/task.dart';

// Week 6
// I estimated this would take me 8 hours. It took me about 9 hours

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _stream = TaskController().getStream();

  late List<Task> _selectedTasks = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: _stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title:
                  Text(_selectedTasks.isEmpty ? 'To Do App' : 'Selected Tasks'),
              actions: _buildAppBarActions(snapshot),
            ),
            body: _body(snapshot),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewTaskPage()),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Widget _body(AsyncSnapshot<List<Task>> snapshot) {
    if (!snapshot.hasData) {
      return const CircularProgressIndicator();
    }

    final tasks = snapshot.data ?? [];
    return ListView.separated(
      itemBuilder: (_, index) => _toWidget(tasks[index]),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: tasks.length,
    );
  }

  Widget _toWidget(Task task) {
    return ListTile(
      title: Text(task.description),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? newValue) {
          print(newValue);
          setState(() {
            task.isCompleted = newValue ?? false;
          });
        },
      ),      
    );
  }

  List<Widget> _buildAppBarActions(AsyncSnapshot<List<Task>> snapshot) {
    if (!snapshot.hasData) {
      return [];
    }

    final tasks = snapshot.data!; 

    if (tasks.any((task) => task.isCompleted)) {
      return [
        IconButton(
          onPressed: () {
            for (final task in tasks.where((task) => task.isCompleted)) {
              TaskController().removeTask(task);
            }            
          },
          icon: const Icon(Icons.delete),
        ),
      ];
    } else {
      return [];
    }
  }
}
