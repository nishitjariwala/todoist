import 'package:flutter/material.dart';
import 'bottomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Drawer.dart';
final _auth = FirebaseAuth.instance;
FirebaseUser user;
String email;
final _firestore= Firestore.instance;
int done=0;
int incomplete=0;


class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {


  void getUser() async {

    try {
      final LoggedInUser = await _auth.currentUser();
      if (LoggedInUser != null) {
        user = LoggedInUser;
        email= user.email;
      }
    } catch (e) {
      print(e);
    }

    print(done);

  }
  void getCounter()async{
    setState(() {
      done=0;
      incomplete=0;

    });
    await for(var snapshot in _firestore.collection('dashBoard').snapshots()){
      for (var taskData in snapshot.documents){
        Timestamp t = taskData.data['start'];
        DateTime d=t.toDate();
        DateTime d1 = DateTime.now();

        String s = '${d1.year}-0${d1.month}-${d1.day+1}';
        DateTime today = DateTime.parse(s);
        final difference = d.difference(today).inDays;




        if(taskData.data['user']==user.email){

          if(difference<0) {
            if(x==0) {
              if (taskData.data['status'] == "done") {
                setState(() {
                  done++;
                });
              }
              else if (taskData.data['status'] == "incomplete") {
                setState(() {
                  incomplete++;
                });
              }
            }
            else if(x==1){
              if(taskData.data['category']==c){
                if (taskData.data['status'] == "done") {
                  setState(() {
                    done++;
                  });
                }
                else if (taskData.data['status'] == "incomplete") {
                  setState(() {
                    incomplete++;
                  });
                }
              }
            }
          }
        }


        //      print(taskData.data);
      }
    }
  }
  



  @override
  void initState() {

    super.initState();
    print(email);

    getUser();
    getCounter();


  }
  String c;
  int x = 0;
  List<String> category = [
    'All',
    'Study',
    'Exercise',
    'Other'
  ];

  int total = done + incomplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerItem(),

      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        iconTheme: IconThemeData(color: Colors.green[900]),

        title: Text("Analysis", style: TextStyle(color: Colors.green[900],),),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: DropdownButton(
                  hint: Text('Choose Catrgory  ',style: TextStyle(fontSize: 20),),

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
                      getCounter();

                    });
                  },
                  items: category.map((value) {
                    return DropdownMenuItem(
                      child: new Text(value,style: TextStyle(color: Colors.green[900],fontSize: 20),),
                      value: value,
                    );
                  }).toList(),
                ),
              ),

            ],
          ),

          Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(color: Colors.green[50],borderRadius: BorderRadius.circular(20)),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Completed Task",style: TextStyle(fontSize: 20,color: Colors.green[900]),),
                          SizedBox(height: 30,),
                          Text(done.toString(),style: TextStyle(fontSize: 40,color: Colors.green[900]),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(color: Colors.green[50],borderRadius: BorderRadius.circular(20)),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Incompleted Task",style: TextStyle(fontSize: 20,color: Colors.green[900]),),
                          SizedBox(height: 30,),
                          Text(incomplete.toString(),style: TextStyle(fontSize: 40,color: Colors.green[900]),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
      bottomNavigationBar: BottomAppBarFunction(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
