import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _db = Firestore.instance;
  final _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final snackBar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: 'Go',
            onPressed: () => null,
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
