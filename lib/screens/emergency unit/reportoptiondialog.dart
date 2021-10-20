import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/map%20screens/stationmap.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

var currentUser = FirebaseAuth.instance.currentUser;
late String name;
late String phone;
enum DialogsAction { yes, cancel }
late String user_id;

class ReportOptionDialog {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  SystemNavigator.pop();
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  var currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    final QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: currentUser.email)
                        .get();
                    user_id = snap.docs[0]['report id'];
                  }
                  print(user_id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationMap(user_id)));
                },
                child: Text(
                  'View Map',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }
}
