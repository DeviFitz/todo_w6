import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../utils/string_validator.dart'; // Import your string_validator utility

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  String _errorMessage = '';
  bool _obscurePassword = true; //for hiding the password
  final Auth _auth = Auth(); // Instance of your Auth class

  // Handle creating an account
  Future<void> _createAccount() async {
    String? error = await _auth.createAccountWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _pwController.text.trim(),
    );
    if (error == null) {
      // Account creation successful, navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
      //Navigator.of(context).pop();
    } else {
      // Account creation failed, update error message
      setState(() {
        _errorMessage = error!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
              validator: validateEmailAddress,
            ),
            // Hide the password while the user types it
            TextFormField(
              controller: _pwController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
              validator: validatePassword,
            ),
            ElevatedButton(
              child: const Text('Create Account'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Validate the form fields
                  try {
                    // Attempt to create the account
                    await _createAccount();
                    // Navigate to the home page
                    //Navigator.pushReplacementNamed(context, '/home');
                    
                  } catch (error) {
                    // If there's an error during account creation, show the error message
                    setState(() {
                      _errorMessage = error.toString();
                    });
                  }
                }
              },
            ),
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }
}
