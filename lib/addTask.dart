import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:custom_switch/custom_switch.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;

class addTask extends StatefulWidget {
  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  final _firestore = Firestore.instance;
  String title;
  String desc;
  DateTime _dateTime;
  DateTime d;
  String date;
  String start_time;
  String end_time;
  DateTime start;
  DateTime end;
  DateTime initialDateTime = DateTime.now();
  List<String> _locations = ['Study', 'Exercise', 'Other'];
  List<String> repeat = ['Daily','Weekly', 'Monthly', 'Yearly'];
  int repeatValue;

  String category;
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  Widget alterBox(String s) {
    return AlertDialog(
      title: Text(s),
      content: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Ok"),
        elevation: 5,
        color: Colors.green,
      ),
    );
  }

  bool status = false;
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
    return AlertDialog(
      title: Text(
        'Add Task',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                title = value;
              },
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Title',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 5.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  desc = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Description',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 5.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            DropdownButton(
              hint: Text('Please choose Catrgory  '),
              value: category,
              onChanged: (newValue) {
                setState(() {
                  category = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            Form(
              key: _FormKey,
              child: Column(
                children: <Widget>[
                  DateTimeFormField(
                    label: "Start Time",
                    initialValue: DateTime.now(),
                    onSaved: (DateTime value) {
                      start = value;
                      date = "${value.day}/${value.month}/${value.year}";
                      start_time = '${value.hour}:${value.minute}';
                      print(start);
                      print(start_time);
                    },
                  ),
                  DateTimeFormField(
                    label: "End Time",
                    initialValue: DateTime.now(),
                    onSaved: (DateTime value) {
                      print("End");
                      end = value;

                      end_time = '${value.hour}:${value.minute}';

                      print(end);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomSwitch(
                  activeColor: Colors.green,
                  value: status,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      status = value;
                    });
                    if(status) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.green[50],
                            title:Text("Choose Repeatation Time"),

                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        repeatValue=1;
                                      });
                                      Navigator.pop(context);

                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Text("Daily",textAlign: TextAlign.center,),
                                      ),
                                      elevation: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        repeatValue=7;
                                      });
                                      Navigator.pop(context);

                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Text("Weekly",textAlign: TextAlign.center,),
                                      ),
                                      elevation: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        repeatValue=30;
                                      },
                                      );
                                      Navigator.pop(context);

                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Text("Monthly",textAlign: TextAlign.center,),
                                      ),
                                      elevation: 10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        repeatValue=365;
                                      });
                                      Navigator.pop(context);

                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Text("yearly",textAlign: TextAlign.center,),
                                      ),
                                      elevation: 10,
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          );
                        },
                      );
                    }


                  },
                ),
                Text("Want To Repeat \n the Task??"),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),

            RaisedButton(
              child: Text("Add", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                _FormKey.currentState.save();
                print("in onpressed");
                if (title == null) {
                  print("check 1");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Title is Empty");
                    },
                  );
                } else if (desc == null) {
                  print("check 2");

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Description is Empty");
                    },
                  );
                } else if (category == null) {
                  print("check 3");

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Select Category");
                    },
                  );
                }

                else {
                  if(status){
                    print("check 4");

                    if(repeatValue==null){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alterBox("Please Select a Duration for repeatation");
                        },
                      );
                    }
                  }
                  print("in db");
                  _firestore.collection('dashBoard').add({
                    'title': title,
                    'desc': desc,
                    'start': start,
                    'end': end,
                    'start_time': start_time,
                    'end_time': end_time,
                    'category': category,
                    'user': email,
                    'date': date,
                    'status': "null",
                    'repeat': status,
                    'duration': repeatValue,
                  });
                  _firestore
                      .collection('dashBoard')
                      .document("HLn0mGw6wSsY4s9qivEp")
                      .delete();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
