import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'signup.dart';

class practice extends StatefulWidget {
  @override
  _practiceState createState() => _practiceState();
}

class _practiceState extends State<practice> {

  String uname;
  String password;

  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  Widget unameField()
  {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "name",
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'String is Empty';
        }
      },
      onSaved: (String value){
        uname=value;
      },
    );
  }
  Widget passwordField()
  {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "password",
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'Required';
        }
      },
      onSaved: (String value){
        uname=value;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Row(
          children: <Widget>[

            Image.asset(
                "images/Todolist.png",
                height: 50,
              ),

          ],
        ),
      ),
      backgroundColor: Colors.red[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Form(
            key: _FormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "TODOist",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                    ),
                  ),
                  unameField(),
                  passwordField(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>ForgotPassword(),
                          ),

                          );
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(


                            onPressed:(){
                              if(!_FormKey.currentState.validate()){
                                return;
                              }
                              _FormKey.currentState.save();
                              print(uname);
                            },
                            color: Colors.green[200],

                            child: Text("Login",style: TextStyle(color: Colors.green[900]),)
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            "Create a new Account",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ) ,
          ),
        ),
      ),
    );
  }
}

