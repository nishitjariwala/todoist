import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/bottomSheet.dart';
import 'package:flash_chat/task_detail.dart';
import 'package:flash_chat/EditTask.dart';

//TODO: Card for DashBoard

class card_dashBoard extends StatefulWidget {
  final String title;
  final String desc;
  final String start_time;
  final String end_time;
  final String date;
  final String category;
  String status;
  String ref;
  bool repeat;
  int duration;
  final Start;
  final End;
  final user;

  card_dashBoard(
      {this.title,
        this.desc,
        this.start_time,
        this.end_time,
        this.status,
        this.ref,
        this.date,
        this.category,
        this.duration,
        this.Start,
        this.End,
        this.repeat,
        this.user,

      });

  @override
  _card_dashBoardState createState() => _card_dashBoardState();
}

class _card_dashBoardState extends State<card_dashBoard> {
  int x=0;
  void fun(){
    if(widget.repeat){
      _firestore.collection('dashBoard').document(widget.ref).updateData({
        'repeat': false,
      });
      String date = '${widget.Start.year}/${widget.Start.month}/${widget.Start.day}';

      _firestore.collection('dashBoard').add({
        'title': widget.title,
        'desc': widget.desc,
        'start': widget.Start,
        'end': widget.End,
        'start_time': widget.start_time,
        'end_time': widget.end_time,
        'category': widget.category,
        'user': widget.user,
        'date': date,
        'status': "null",
        'repeat': true,
        'duration': widget.duration,
      });

    }
  }


  final _firestore = Firestore.instance;
  Icon icon(String s) {
    if (s == "null") {
      return Icon(
        Icons.check_box_outline_blank,
        color: Colors.green[900],
      );
    } else if (s == "done") {
      return Icon(
        Icons.check,
        color: Colors.green[900],
      );
    } else {
      return Icon(
        Icons.close,
        color: Colors.green[900],
      );
    }
  }

  Color bgcolor(String s) {
    if (s == "null") {
      return Colors.white;
    } else if (s == "done") {
      return Colors.green[300];
    } else {
      return Colors.red[200];
    }
  }
  //TODO: dialogBox for edit Profile
  Widget buildEditTaskDialog(BuildContext context) {
    return EditTask(title: widget.title,end: widget.End,category: widget.category,ref: widget.ref,desc: widget.desc,start: widget.Start,);
  }

  //TODO: BuildBottomSheet: DashBoard
  //Bottom Sheet

  Widget buildBottomSheet(BuildContext context) {
    //print(widget.title);
    return BuildBottomSheet(
      title: widget.title,
      status: widget.status,
      ref: widget.ref,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fun();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetail(Category: widget.category,date: widget.date,title: widget.title,desc: widget.desc,start_time: widget.start_time,end_time: widget.end_time),
            ),
          );
        },
        child: Card(

            elevation: 10,
            color: bgcolor(widget.status),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context, builder: buildBottomSheet);
                  },
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: icon(widget.status),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text("${widget.title}",
                              style: TextStyle(
                                  color: Colors.green[900], fontSize: 25)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Text("${widget.desc}",
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${widget.start_time}\n-\n${widget.end_time}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildEditTaskDialog(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    child: Icon(
                      Icons.mode_edit,
                      color: Colors.green[900],
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    _firestore.collection('dashBoard').document(widget.ref).delete();

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.green[900],
                      size: 30,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
