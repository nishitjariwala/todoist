import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dashboard.dart';

class SignUp extends StatefulWidget {
  static const String id="signup";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {



  String password;
  final _firestore = Firestore.instance;
  String email;
  final _auth = FirebaseAuth.instance;
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
  String name;
  Widget nameField()
  {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Name",
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'name is Required';
        }

      },
      onSaved: (String value){
        name=value;
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
          return 'Password is Required';
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
  String Number;
  Widget mobileNumberField()
  {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Mobile Number",
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'Number is Required';
        }
        else if(value.length<10)
        {
          return 'Enter Valid Number';
        }
      },
      onSaved: (String value){
        Number=value;
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
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green[900],
                      ),
                    ),
                    nameField(),
                    emailField(),
                    mobileNumberField(),
                    passwordField(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(

                          child: GestureDetector(
                            child: RaisedButton(


                                onPressed:() async{
                                  if(!_FormKey.currentState.validate()){
                                    return;
                                  }
                                  _FormKey.currentState.save();

                                  print (email);
                                  print(password);
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    if(newUser!=null){
                                      _firestore.collection('userInformation').add({
                                        'email': email,
                                        'number': Number,
                                        'name': name,
                                      });
                                    }
                                    if(newUser!=null)
                                    {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=> DashBoard(),
                                      ),
                                      );
                                    }
                                  }
                                  catch(e)
                                  {
                                    print(e);
                                  }
//

                                },
                                color: Colors.green[200],

                                child: Text("Sign Up",style: TextStyle(color: Colors.green[900]),)
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
