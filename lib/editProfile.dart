import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//TODO: Edit Profile Screen Screen
class editProfile extends StatefulWidget {
  final _firestore = Firestore.instance;
  String name;
  String number;
  String ref;
  editProfile({this.name,this.number,this.ref});
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override

  Widget buildErrorDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Please Edit First"),
      content: RaisedButton(onPressed: (){Navigator.pop(context);},child: Text("Ok"),),
    );
  }


  void update(String name,String number){
   widget._firestore.collection('userInformation').document(widget.ref).updateData({
     'name': name,
     'number': number,
   });
  }

  TextEditingController controllerName;
  TextEditingController controllerNumber;

  void initState() {
    super.initState();
    controllerName = TextEditingController(text: widget.name);
    controllerNumber = TextEditingController(text: widget.number);

  }
  String eName;
  String eNumber;
  int a=0;
  @override
  Widget build(BuildContext context) {

  return AlertDialog(
    title: Text(
      'Edit Profile',
      textAlign: TextAlign.center,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextField(
          onChanged: (value) {
            a++;
            widget.name=value;
          },
          controller: controllerName,

          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'number',
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
              a++;
              widget.number=value;
            },
            controller: controllerNumber,

            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Number',
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
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FlatButton(
            onPressed: (){
              update(widget.name, widget.number);



              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 12),
              child: Text("Edit",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            color: Colors.green,

          ),
        ),

      ],
    ),
  );

  }
}
