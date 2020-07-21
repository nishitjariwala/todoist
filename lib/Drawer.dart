import 'package:flutter/material.dart';
import 'addFeedBack.dart';
import 'package:firebase_auth/firebase_auth.dart';

class drawerItem extends StatefulWidget {

  @override
  _drawerItemState createState() => _drawerItemState();
}

class _drawerItemState extends State<drawerItem> {
  final _auth = FirebaseAuth.instance;
  String email;
  void getUser() async {
    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        setState(() {
          email = user.email;

        });


      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.red[50],
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TODOist',
                    style: TextStyle(fontSize: 30, color: Colors.green[900]),
                  ),
                  Text(email,style: TextStyle( fontSize: 20,color: Colors.green[900]))
                ],
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
                color: Colors.green[200],
              ),
            ),
            ListTile(
              title: Text(
                'Feedback',
                style: TextStyle(fontSize: 20, color: Colors.green[900]),
              ),
              onTap: () {
                // Update the state of the app.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addFeedBack(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'About Us',
                style: TextStyle(fontSize: 20, color: Colors.green[900]),
              ),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: Text(
                'Sign out',
                style: TextStyle(fontSize: 20, color: Colors.green[900]),
              ),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      ),
    );
  }
}
