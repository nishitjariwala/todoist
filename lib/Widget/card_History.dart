import 'package:flutter/material.dart';
import 'package:flash_chat/task_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//TODO: Card for History

class card_History extends StatefulWidget {
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

  card_History(
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
  _card_HistoryState createState() => _card_HistoryState();
}

class _card_HistoryState extends State<card_History> {
  final _firestore = Firestore.instance;
  void status(){
    if(widget.status=="null"){
      _firestore.collection('dashBoard').document(widget.ref).updateData({
        'status': "incomplete",
      });
    }
  }

  void fun(){
    if(widget.repeat){
      _firestore.collection('dashBoard').document(widget.ref).updateData({
        'repeat': false,
      });
      String date = '${widget.Start.year}-${widget.Start.month}-${widget.Start.day}';

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



  //Bottom Sheet
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    status();
    fun();

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
              builder: (context) => TaskDetail(Category: widget.category,date: widget.date,title: widget.title,desc: widget.desc,start_time: widget.start_time,end_time: widget.end_time,),
            ),
          );
        },
        child: Card(

            elevation: 10,
            color: bgcolor(widget.status),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${widget.start_time} - ${widget.end_time}",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          widget.date,
                          style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )),
      ),
    );
  }
}
