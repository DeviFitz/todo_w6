import 'package:flutter/material.dart';
import 'package:todo_app/services/local_storage.dart';
import 'pages/home_page.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 243, 141, 182),
        useMaterial3: true,
      ),
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}
