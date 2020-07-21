import 'package:flutter/material.dart';
import 'bottomAppBar.dart';
import 'addTask.dart';
import 'Drawer.dart';
import 'package:flash_chat/Widget/card_dashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;
final _firestore = Firestore.instance;

//TODO: x variable is useful in sorting with category

int x = 0;
String c;


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<String> category = [
    'All',
    'Study',
    'Exercise',
    'Other'
  ];

  Widget buildAddTaskDialog(BuildContext context) {
    return addTask();
  }

  void getUser() async {
    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        setState(() {
          email = user.email;

        });
//        email = user.email;
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

  Widget cards(String title, String desc, String start_time, String end_time) {
    return card_dashBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Row(
          children: <Widget>[
            Text(
              "Dashboard",
              style: TextStyle(
                color: Colors.green[900],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[200],
      ),
      drawer: drawerItem(),

      //backgroundColor: Colors.white,
      //TODO: Body for DashBoard

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


                    streamBuilder_DashBoard(firestore: _firestore),


                  ],
                ),
              ),
            ),
          ],
        ),

      ),

      //TODO: BottomNavigatorBar For DashBoard

      bottomNavigationBar: bottomAppBarDashBoard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => buildAddTaskDialog(context),
          );
        },
        backgroundColor: Colors.green[200],
        child: Icon(
          Icons.add,
          color: Colors.green[900],
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//TODO: StreamBuilder for DashBoard

class streamBuilder_DashBoard extends StatelessWidget {
  const streamBuilder_DashBoard({
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
        List<card_dashBoard> taskWidgets = [];

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
            Timestamp t1 =  task.data['end'];
            bool repeat = task.data['repeat'];
//            //TODO: for sorting of Todays Task
//
//            final start = t.toDate();
//            final end = t1.toDate();
//
//
//
//            //for calculate start of task
//
//            String m;
//            if (start.month <= 9) {
//              m = '0${start.month}';
//            } else {
//              m = '$start.month';
//            }
//            String day;
//            if (start.day <= 9) {
//              day= '0${start.day}';
//            } else {
//              day= '${start.day}';
//            }
//            String s = '${start.year}-$m-$day';
//
//            DateTime start1 = DateTime.parse(s);
//
//            //for calculate today's date for sorting
//
//            DateTime date = DateTime.now();
//            String month;
//            if (date.month <= 9) {
//              month = '0${date.month}';
//            } else {
//              month = '$date.month';
//            }
//            //String day;
//            if (date.day <= 9) {
//              day= '0${date.day}';
//            } else {
//              day= '${date.day}';
//            }
//            String dateString = '${date.year}-$month-$day';
//
//            //sorting
//
//            DateTime today = DateTime.parse(dateString);
//            final difference = start1.difference(today).inDays;
//
//
            final start = t.toDate();
            final end = t1.toDate();

            DateTime date = DateTime.now();
            String month;
            if(date.month<=9){
              month = '0${date.month}';
            }
            else{
              month = '$date.month';
            }

            String day;
            if (date.day <= 9) {
              day= '0${date.day}';
            } else {
              day= '${date.day}';
            }
            String dateString = '${date.year}-$month-$day';
            DateTime today = DateTime.parse(dateString);

            final difference = start.difference(today).inDays;


            if (loggedInUser == dbUser) {
              if (difference == 0) {
                final ref = task.documentID;
                if(repeat){

                  final duration = task.data['duration'];

                  DateTime Start = start.add(Duration(days: duration));
                  DateTime End = end.add(Duration(days: duration));

                  if(x==0) {
                    final taskWidget = card_dashBoard(
                      title: title,
                      desc: desc,
                      start_time: Start_time,
                      end_time: End_time,
                      status: status,
                      ref: ref,
                      date: d,
                      category: category,
                      Start: Start,
                      duration: duration,
                      End: end,
                      repeat: repeat,
                      user: email,
                    );
                    taskWidgets.add(taskWidget);
                  }
                  else{
                    if(c==category){
                      final taskWidget = card_dashBoard(
                        title: title,
                        desc: desc,
                        start_time: Start_time,
                        end_time: End_time,
                        status: status,
                        ref: ref,
                        date: d,
                        category: category,
                        Start: Start,
                        duration: duration,
                        End: end,
                        repeat: repeat,
                        user: email,

                      );
                      taskWidgets.add(taskWidget);
                    }
                  }


                }
                else{
                  if(x==0) {
                    final taskWidget = card_dashBoard(
                      title: title,
                      desc: desc,
                      start_time: Start_time,
                      end_time: End_time,
                      status: status,
                      ref: ref,
                      date: d,
                      category: category,
                      Start: 1,
                      duration: 1,
                      End: end,
                      repeat: repeat,
                      user: email,

                    );
                    taskWidgets.add(taskWidget);
                  }
                  else{
                    if(c==category){
                      final taskWidget = card_dashBoard(
                        title: title,
                        desc: desc,
                        start_time: Start_time,
                        end_time: End_time,
                        status: status,
                        ref: ref,
                        date: d,
                        category: category,
                        Start: 1,
                        duration: 1,
                        End: end,
                        repeat: repeat,
                        user: email,

                      );
                      taskWidgets.add(taskWidget);
                    }
                  }
                }
              }
            }
          }
        } else {
          return Center(
              child: Text(
            "No Task",
            style: TextStyle(color: Colors.black),
          ));
        }

        if(taskWidgets.length==0){
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: Text("No Task")),
            ],
          ));
        }
        else{
          return Column(
            children: taskWidgets,
          );
        }

      },
    );
  }
}
