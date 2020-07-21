import 'package:flutter/material.dart';
import 'bottomAppBar.dart';
import 'package:flash_chat/Drawer.dart';
import 'package:flash_chat/Widget/card_TaskList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;
final _firestore = Firestore.instance;
int x = 0;
String c;

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> category = ['All', 'Study', 'Exercise', 'Other'];

  int a = 1;

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
      drawer: drawerItem(),

      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Text(
          "List",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: <Widget>[
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  hint: Text('Choose Catrgory  '),
                  value: c,
                  onChanged: (newValue) {
                    setState(() {
                      c = newValue;
                      if(c=='All'){
                        x=0;
                      }
                      else{
                        x = 1;

                      }

                    });
                  },
                  items: category.map((value) {
                    return DropdownMenuItem(
                      child: new Text(value,style: TextStyle(color: Colors.green[900]),),
                      value: value,
                    );
                  }).toList(),
                ),

              ],
            ),

            Expanded(
              child: Container(
                child: ListView(

                  children: <Widget>[


                    streamBuilder_TaskList(firestore: _firestore),


                  ],
                ),
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomAppBarFunction(),
    );
  }
}


//TODO: StreamBuilder for TaskList


class streamBuilder_TaskList extends StatelessWidget {
  const streamBuilder_TaskList({
    Key key,
    @required Firestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('dashBoard')
          .orderBy('start', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        List<card_TaskList> taskWidgets = [];

        if (snapshot.hasData) {
          final dashBoard = snapshot.data.documents;
          for (var task in dashBoard) {
            final title = task.data['title'];
            final desc = task.data['desc'];
            final Start_time = task.data['start_time'];
            final End_time = task.data['end_time'];
            final dbUser = task.data['user'];
            final status = task.data['status'];
            final d = task.data['date'];
            final category = task.data['category'];
            final loggedInUser = email;

            Timestamp t = task.data['start'];
            Timestamp t1 = task.data['end'];

            //TODO: For sorting of future Task

            final start = t.toDate();
            final end = t1.toDate();
            DateTime date = DateTime.now();
            String month;
            if (date.month <= 9) {
              month = '0${date.month}';
            } else {
              month = '$date.month';
            }
            String dateString = '${date.year}-$month-${date.day}';
            DateTime today = DateTime.parse(dateString);

            final difference = start.difference(today).inDays;
            //print(difference);

            if (loggedInUser == dbUser) {
              if (difference >0) {
                final ref = task.documentID;
                //print(title);
                if(x==0) {
                  final taskWidget = card_TaskList(
                    title: title,
                    desc: desc,
                    start_time: Start_time,
                    end_time: End_time,
                    status: status,
                    ref: ref,
                    date: d,
                    category: category,
                    end: end,
                    Start: start,
                  );
                  taskWidgets.add(taskWidget);
                }
                else{
                  if(c==category){
                    final taskWidget = card_TaskList(
                      title: title,
                      desc: desc,
                      start_time: Start_time,
                      end_time: End_time,
                      status: status,
                      ref: ref,
                      date: d,
                      category: category,
                      Start: start,
                      end: end,
                    );
                    taskWidgets.add(taskWidget);
                  }
                }
              }
            }
          }
        } else {
          return Center(
              child: Text(
            "No Data",
            style: TextStyle(color: Colors.black),
          ));
        }

        if (taskWidgets.length == 0) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No Task"),
            ],
          ));
        } else {
          return Column(
            children: taskWidgets,
          );
        }
      },
    );
  }
}
