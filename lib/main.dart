import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/login_page.dart'; // Ensure this import path matches your project structure
import '/pages/home_page.dart'; // Ensure this import path matches your project structure
import '/data/expenses_data.dart';
import 'package:firebase_core/firebase_core.dart';
// Assuming this manages your app's state, ensure the path is correct

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Initialize Firebase App
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Something went wrong with Firebase initialization.'),
              ),
            ),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(), // Initialize your expenses data provider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Define the initial route
        routes: {
          '/': (context) => LoginPage(), // Define LoginPage as the initial route
          '/home': (context) => HomePage(), // Route for HomePage
        },
      ),
    );
  }
}