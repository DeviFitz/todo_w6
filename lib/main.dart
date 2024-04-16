import 'package:flutter/material.dart';
import 'package:todo_app/services/local_storage.dart';
import 'lib/pages/create_account_page.dart';
import 'lib/pages/opening_page.dart';//Import opening page W7
//import 'pages/home_page.dart'; 
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'lib/pages/sign_in_account_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().initialize();

  //step 3.4 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const OpeningPage(), //Open the app to the opening_page
      routes: {
        // Define named routes
        '/createAccount': (context) => CreateAccountPage(),
        '/signIn': (context) => SignInAccountPage(),
      },
    );
  }
}

// To navigate to the other pages 
class OpeningPage extends StatelessWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opening Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the create account page
                Navigator.pushNamed(context, '/createAccount');
              },
              child: Text('Create Account'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the sign in page
                Navigator.pushNamed(context, '/signIn');
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}