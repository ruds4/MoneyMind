import 'package:flutter/material.dart';
import 'package:money_mind/components/my_textfield.dart';
import 'package:money_mind/components/my_button.dart';
import 'package:money_mind/components/square_tile.dart';
import 'home_page.dart'; // Make sure to import your HomePage class correctly

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final unameController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Icon(Icons.lock, size: 100),
              const SizedBox(height: 50),
              const Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: unameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: pwdController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              MyButton(
                // Correct the onTap callback
                onTap: () => signUserIn(context),
                // Assuming MyButton takes an onTap parameter
                // Add other necessary parameters for MyButton
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?', style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(width: 4),
                  const Text(
                    'Register Now!',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Implement the navigation logic within signUserIn
  void signUserIn(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    // Make sure HomePage is defined and imported
  }
}