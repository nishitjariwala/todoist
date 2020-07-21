import 'package:flutter/material.dart';
import 'bottomAppBar.dart';



class TaskDetail extends StatefulWidget {
  final String title;
  final String desc;
  final String start_time;
  final String end_time;
  final String Category;
  final String date;
  TaskDetail({this.title,this.end_time,this.start_time,this.desc,this.date,this.Category});
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {

  Widget details(String title, String desc, String start_time, String end_time,String date,String category){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
      child: ListView(
        children: <Widget>[
          Text(
            "Title:- $title",
            style: TextStyle(
              fontSize: 25,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Description:- $desc",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10,),

          Text(
            "Date:- $date",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10,),

          Text(
            "Start Time:- $start_time",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "End Time:- $end_time",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          Text(
            "Category:- $category",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        iconTheme: IconThemeData(color: Colors.green[900]),

        title: Text("Details", style: TextStyle(color: Colors.green[900],),),
      ),

      body: details(widget.title,widget.desc,widget.start_time,widget.end_time,widget.date,widget.Category),

      bottomNavigationBar: BottomAppBarFunction(),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

}

