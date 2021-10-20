import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/map%20screens/firescreen.dart';
import 'package:firebasetest/map%20screens/hospitalscreen.dart';
import 'package:firebasetest/map%20screens/policescreen.dart';
import 'package:firebasetest/map%20screens/rtpcrscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;

var currentUser = FirebaseAuth.instance.currentUser;
late String name;
late String phone;
enum DialogsAction { yes, cancel }

class ConfirmViewMap {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    String userid = currentUser.uid;
    final loc.Location location = loc.Location();
    StreamSubscription<loc.LocationData>? _locationSubscription;

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
                  try {
                    final loc.LocationData _locationResult =
                        await location.getLocation();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userid)
                        .set({
                      'latitude': _locationResult.latitude,
                      'longitude': _locationResult.longitude,
                    }, SetOptions(merge: true));
                  } catch (e) {
                    print(e);
                  }
                  if (title == "Closest Police Station") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PoliceScreen()),
                    );
                  }
                  if (title == "Closest Hospital") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalScreen()),
                    );
                  }
                  if (title == "Closest RT-PCR Testing Sites") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => rtpcrScreen()),
                    );
                  }
                  if (title == "Closest Fire Station") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FireScreen()),
                    );
                  }
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
