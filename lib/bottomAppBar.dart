import 'package:flutter/material.dart';
import 'history.dart';
import 'analysis.dart';
import 'taskList.dart';
import 'profile.dart';
import 'dashboard.dart';

//TODO: BottomAppBar for history, List of Task, Analysis, Profile

class BottomAppBarFunction extends StatelessWidget {

  Widget build(BuildContext context) {
    return BottomAppBar(
      //color: Colors.red[50],
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          color: Colors.green[900],
                        ),
                        Text("History",
                          style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 15,
                        )),
                      ],
                    )),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => History(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.show_chart,
                          color: Colors.green[900],
                        ),
                        Text("Analysis",
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 15,
                            )),
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Analysis(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.green[900],
                          size: 35,
                        ),

                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoard(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.list,
                          color: Colors.green[900],
                        ),
                        Text("List",
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 15,
                            )),
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskList(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Colors.green[900],
                        ),
                        Text("Profile",
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 15,
                            )),
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: bottomAppBar for DashBoard

class bottomAppBarDashBoard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          color: Colors.green[900],
                        ),
                        Text("History",style: TextStyle(color: Colors.green[900]),)

                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => History(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.show_chart,
                          color: Colors.green[900],
                        ),
                        Text("Analisis",style: TextStyle(color: Colors.green[900]),)

                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Analysis(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                //child: Icon(Icons.history)
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.list,
                          color: Colors.green[900],
                        ),
                        Text("List",style: TextStyle(color: Colors.green[900]),)

                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskList(),
                    ),
                  );
                },
              ),
            ),
            Expanded(

              child: GestureDetector(
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Colors.green[900],
                        ),
                        Text("Profile",style: TextStyle(color: Colors.green[900]),)
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

