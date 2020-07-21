import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'signup.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static const String id="login_screen";
  @override

  _practiceState createState() => _practiceState();
}

class _practiceState extends State<Login> {

  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool progress= false;

  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  Widget emailField()
  {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'Email is Empty';
        }

      },
      onSaved: (String value){
        email=value;
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
        else if(value.length<6)
        {
          return 'Please Enter Proper Password (Min.Length: 6)';
        }
      },
      onSaved: (String value){
        password=value;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.green[900]),
          title: Row(
            children: <Widget>[

              Hero(
                tag: "logo",
                child: Image.asset(
                  "images/Todolist.png",
                  height: 50,
                ),
              ),

            ],
          ),
        ),
        backgroundColor: Colors.green[50],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Form(
              key: _FormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                    ),
                  ),
                  emailField(),
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
                        child: GestureDetector(
                          child: RaisedButton(


                              onPressed:()async{
                                setState(() {
                                  progress=true;
                                });
                                if(!_FormKey.currentState.validate()){
                                  return;
                                }
                                _FormKey.currentState.save();
                                try {
                                  final user = await _auth
                                      .signInWithEmailAndPassword(
                                      email: email, password: password);
                                  if (user != null) {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => DashBoard()),
                                    );

                                  }
                                }
                                catch(e){
                                  print(e);
                                  setState(() {
                                    progress: false;
                                  });
                                }


                              },
                              color: Colors.green[200],

                              child: Text("Login",style: TextStyle(color: Colors.green[900]),)
                          ),
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
      ),
    );
  }
}

