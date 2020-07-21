import 'package:flutter/material.dart';
import 'editProfile.dart';
import 'bottomAppBar.dart';
import 'welcome_screen.dart';
import 'addFeedBack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;
final _firestore = Firestore.instance;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void getUser() async {
    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        email = user.email;
        print(email);
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

  //TODO: dialogBox for edit Profile
  Widget buildEditProfileDialog(BuildContext context) {
    return editProfile(name: name1, number: number, ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerItem(),
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.green[900],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      buildEditProfileDialog(context),
                );
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => editProfile(),
//                  ),
//                );
              },
              child: Container(
                child: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilderForProfile(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarFunction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

String name1;
String number;
String ref;

//TODO: Stream Builder for profile
class StreamBuilderForProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('userInformation').snapshots(),
      builder: (context, snapshot) {
        List<Widget> wid = [];

        if (snapshot.hasData) {
          final userInformation = snapshot.data.documents;
          for (var user in userInformation) {
            //final time = getTime(task.data['end_time.']);

            final dbemail = user.data['email'];
            final loggedInUser = email;

            if (loggedInUser == dbemail) {
              ref = user.documentID;
              name1 = user.data['name'];
              number = user.data['number'];

              final profileWidget = profileScreen(
                email: dbemail,
                name: name1,
                number: number,
              );
              wid.add(profileWidget);
            }
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: wid,
        );
      },
    );
  }
}

String reference;

//TODO: profile Screen
class profileScreen extends StatelessWidget {
  final String name;
  final String number;
  final String email;

  profileScreen({
    this.name,
    this.number,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(
              Icons.contacts,
              color: Colors.green[900],
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[900],
              ),
            ),
          ),
          color: Colors.green[100],
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        ),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.call,
              color: Colors.green[900],
            ),
            title: Text(
              number,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[900],
              ),
            ),
          ),
          color: Colors.green[100],
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.green[900],
            ),
            title: Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[900],
              ),
            ),
          ),
          color: Colors.green[100],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => addFeedBack()));
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.green[900],
              ),
              title: Text(
                "FeedBack",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                ),
              ),
            ),
            color: Colors.green[100],
          ),
        ),
        GestureDetector(
          onTap: () {
            _auth.signOut();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => welcome_screen()));
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>),);
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: ListTile(
              title: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green[900],
                  ),
                ),
              ),
            ),
            color: Colors.green[100],
          ),
        ),
      ],
    );
  }
}
