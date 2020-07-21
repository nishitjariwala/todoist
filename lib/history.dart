import 'package:flutter/material.dart';
import 'task_detail.dart';
import 'bottomAppBar.dart';
import 'package:flash_chat/Widget/card_History.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Drawer.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;
final _firestore= Firestore.instance;
int x = 0;
String c;



class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> category = [
    'All',
    'Study',
    'Exercise',
    'Other'
  ];


  int a=1;

  void getUser() async {
    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        setState(() {
          email= user.email;

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
    return Scaffold(
      backgroundColor: Colors.green[50],
      drawer: drawerItem(),

      appBar: AppBar(
        backgroundColor: Colors.green[200],
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Text(
          "History",
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


                    streamBuilder_History(firestore: _firestore),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarFunction(),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Colors.green[200],
//        child: Icon(Icons.add,color: Colors.green[900],size: 40,),
//      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


//TODO: StreamBuilder for History

class streamBuilder_History extends StatelessWidget {
  const streamBuilder_History({
    Key key,
    @required Firestore firestore,
  }) : _firestore = firestore, super(key: key);

  final Firestore _firestore;



  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('dashBoard').orderBy('start',descending: true).snapshots(),
      builder: (context,snapshot){
        List<card_History> taskWidgets=[];

        if(snapshot.hasData){
          final dashBoard= snapshot.data.documents;
          for(var task in dashBoard){
            final title = task.data['title'];
            final desc = task.data['desc'];
            final Start_time = task.data['start_time'];
            final End_time = task.data['end_time'];
            final dbUser = task.data['user'];
            final status = task.data['status'];
            final d = task.data['date'];
            final category = task.data['category'];
            final loggedInUser=email;
            bool repeat = task.data['repeat'];



            Timestamp t = task.data['start'];
            Timestamp t1 = task.data['end'];
            //TODO: For sorting of past Task

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
            String dateString = '${date.year}-$month-${date.day+1}';
            DateTime today = DateTime.parse(dateString);

            final difference = start.difference(today).inDays;
            //print(difference);


            if (loggedInUser == dbUser) {
              if (difference <0) {
                final ref = task.documentID;


                if(repeat){

                  final duration = task.data['duration'];

                  DateTime Start = start.add(Duration(days: duration));
                  DateTime End = end.add(Duration(days: duration));

                  if(x==0) {
                    final taskWidget = card_History(
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
                      final taskWidget = card_History(
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
                    final taskWidget = card_History(
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
                      final taskWidget = card_History(
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


                //print(title);

              }
            }
          }


        }
        else{
          return Center(child: Text("No Data",style: TextStyle(color: Colors.black),));
        }


        if(taskWidgets.length==0){
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("No Task"),
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
