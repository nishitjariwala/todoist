import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class welcome_screen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _welcome_screenState createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: Image.asset(
                "images/Todolist.png",
                height: 200,
              ),
            ),
            Text(
              "TODOist",
              style: TextStyle(
                fontFamily: 'Monoton_Regular1',
                fontSize: 30,
                color: Colors.green[900],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: new Center(
                    child: Text(
                      "Login ",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
//
          ],
        ),
      ),
//backgroundColor: Colors.red[100],
    );

  }
}
