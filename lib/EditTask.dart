import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;

class EditTask extends StatefulWidget {
  final ref;
  String title;
  String desc;
  DateTime start;
  DateTime end;
  String category;
  EditTask(
      {this.end, this.category, this.title, this.ref, this.desc, this.start});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _firestore = Firestore.instance;
  //String title;
  //String desc;
  DateTime _dateTime;
  DateTime d;
  String date;
  String start_time;
  String end_time;
  DateTime start;
  DateTime end;
  DateTime initialDateTime = DateTime.now();
  List<String> _locations = ['Study', 'Exercise', 'Other'];

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


  TextEditingController controllerTitle;
  TextEditingController controllerDesc;


  @override
  void initState() {
    super.initState();
    getUser();
    controllerTitle = TextEditingController(text: widget.title);
    controllerDesc = TextEditingController(text: widget.desc);

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Task"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                //Do something with the user input.
                widget.title = value;
              },
              controller: controllerTitle,
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
                  widget.desc = value;
                },
                controller: controllerDesc,
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
              value: widget.category,
              onChanged: (newValue) {
                setState(() {
                  widget.category = newValue;
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
                    initialValue: widget.start,
                    onSaved: (DateTime value) {
                      widget.start = value;
                      date = "${value.day}/${value.month}/${value.year}";
                      start_time = '${value.hour}:${value.minute}';
                      //print(start);
                      print(start_time);
                    },
                  ),
                  DateTimeFormField(
                    label: "End Time",
                    initialValue: widget.end,
                    onSaved: (DateTime value) {
                      print("End");
                      widget.end = value;

                      end_time = '${value.hour}:${value.minute}';

                      print(end);
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                _FormKey.currentState.save();

                if (widget.title == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Title is Empty");
                    },
                  );
                } else if (widget.desc == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Description is Empty");
                    },
                  );
                } else if (widget.category == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alterBox("Select Category");
                    },
                  );
                } else {
                  print(widget.title);
                  print(widget.desc);
                  print(widget.start);
                  print(widget.end);
                  print(start_time);
                  print(end_time);
                  print(widget.category);
                  print(email);
                  print(date);

                  _firestore.collection('dashBoard').document(widget.ref).setData({
                    'title': widget.title,
                    'desc': widget.desc,
                    'start': widget.start,
                    'end': widget.end,
                    'status': "null",
                    'user': email,
                    'start_time': start_time,
                    'end_time': end_time,
                    'date': date,
                    'category': widget.category,
                  });
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
