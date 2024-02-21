import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/login_page.dart'; // Ensure this import path matches your project structure
import '/pages/home_page.dart'; // Ensure this import path matches your project structure
import '/data/expenses_data.dart'; // Assuming this manages your app's state, ensure the path is correct

void main() {
  runApp(const MyApp());
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