import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore= Firestore.instance;


class BuildBottomSheet extends StatefulWidget {
  String status;
  String title;
  String ref;
  BuildBottomSheet({this.status,this.title,this.ref});
  @override
  _BuildBottomSheetState createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {


  //TODO: Update Function For Task Status
  void update(String title,String status){
    Map<String,String> data =<String,String>{
      'title': title,
      'status': status,
    };

    _firestore.collection('dashBoard').document(widget.ref).updateData(data).whenComplete((){
      print ("Updated");

    }).catchError((e)=>print(e));

  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xff757575),
      child: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: (){

                  update(widget.title,'done');


                  Navigator.pop(context);
                },
                child: Card(

                  elevation: 10,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){

                update(widget.title,'incomplete');

                Navigator.pop(context);

              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Incompleted',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

            ),
            GestureDetector(
              onTap: (){

                update(widget.title,'null');

                Navigator.pop(context);

              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Reset',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
    );;

  }
}
