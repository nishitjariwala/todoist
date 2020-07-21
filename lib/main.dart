import 'package:flutter/material.dart';
import 'login.dart';
import 'welcome_screen.dart';
import 'signup.dart';

void main() => runApp(Todoist());

class Todoist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Roboto',
          iconTheme: IconThemeData(color: Colors.green[900]),
          cursorColor: Colors.green[900],
          hintColor: Colors.green,
          primaryTextTheme: TextTheme(
              body1: TextStyle(color: Colors.green),
              display1: TextStyle(color: Colors.green),
              title: TextStyle(color: Colors.green),
              button: TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.green[50],
          primaryColor: Colors.green,
          selectedRowColor: Colors.green),
      debugShowCheckedModeBanner: false,  
      initialRoute: welcome_screen.id,
      routes: {
        welcome_screen.id: (context) => welcome_screen(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}
