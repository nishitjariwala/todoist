import 'package:flutter/material.dart';
import 'Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';

List<String> feedback = [];
String f = "null";
final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
FirebaseUser user;
String email;
final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();


class addFeedBack extends StatefulWidget {
  @override
  _addFeedBackState createState() => _addFeedBackState();
}

class _addFeedBackState extends State<addFeedBack> {
  void getUser() async {
    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        email = user.email;
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
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Feedback",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 25,
              ),
            ),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard() ,),);
              },
              icon: Icon(Icons.home,color: Colors.green[900],),
            )
          ],
        ),
        backgroundColor: Colors.green[50],
        elevation: 0,
      ),
      drawer: drawerItem(),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              CardFeedBack(
                text: "Very Good",
              ),
              CardFeedBack(
                text: "Good",
              ),
              CardFeedBack(
                text: "okay",
              ),
              CardFeedBack(
                text: "bad",
              ),
              CardFeedBack(
                text: "So Bad",
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                child: TextField(
                  onChanged: (value) {
                    f = value;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter Your Feedback",
                    labelText: "Feedback",
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 3.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 5.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(


        child: FlatButton(
          onPressed: () {
            if (feedback.length == 1) {
              try {
                _firestore.collection('feedBack').add({
                  'user': email,
                  'feedBack': f,
                  'rating': feedback[0],
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addFeedBack(),
                  ),
                );
              } catch (e) {
                print(e);
              }

              print("submit");
            } else {
              print("Can't submit");
            }
            feedback.clear();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          color: Colors.green,
        ),
        color: Colors.green,
        elevation: 0,
      ),
    );
  }
}

class CardFeedBack extends StatefulWidget {
  final String text;

  CardFeedBack({this.text});

  @override
  _CardFeedBackState createState() => _CardFeedBackState();
}

class _CardFeedBackState extends State<CardFeedBack> {
  int a = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
      child: GestureDetector(
        onTap: () {
          setState(() {
            a == 0 ? a = 1 : a = 0;
          });
          a == 0 ? feedback.remove(widget.text) : feedback.add(widget.text);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.text,
                  style: TextStyle(color: Colors.green[900], fontSize: 20),
                ),
                Icon(a == 0 ? Icons.star_border : Icons.star,size: 30,),
              ],
            ),
          ),
          color: a == 0 ? Colors.white : Colors.grey[350],
          elevation: 10,
        ),
      ),
    );
  }
}
