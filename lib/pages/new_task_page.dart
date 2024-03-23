import 'package:flutter/material.dart';
import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/model/task.dart';
// import 'package:todo_app/pages/home_page.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TextField for new task
        TextField(
          controller: _controller,
          minLines: 3,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'New task'),
        ),

        // Save button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              TaskController().insertTask(_controller.text);
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ],
    ),
  );
}

  @override
  void dispose() {
    // End the controller when the widget is done
    _controller.dispose();
    super.dispose();
  }
}
