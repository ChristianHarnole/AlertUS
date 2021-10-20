import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/user/confirmviewmap.dart';
import 'package:firebasetest/screens/user/reportdialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PoliceReport extends StatefulWidget {
  @override
  _PoliceReport createState() => _PoliceReport();
}

class _PoliceReport extends State<PoliceReport> {
  late String name;
  late String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Police Report"),
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "WHAT HAS HAPPENED?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 5.0,
                    children: <Widget>[
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Homicide Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Homicide Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.emoji_people_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "HOMICIDE",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Violence/Brawl Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Violence/Brawl Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.dangerous_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "VIOLENCE/BRAWL",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                              onTap: () async {
                                var currentUser =
                                    FirebaseAuth.instance.currentUser;

                                if (currentUser != null) {
                                  final QuerySnapshot snap =
                                      await FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .where('email',
                                              isEqualTo: currentUser.email)
                                          .get();
                                  setState(() {
                                    name = snap.docs[0]['name'];
                                    phone = snap.docs[0]['phone'];
                                  });
                                  // FirebaseFirestore.instance
                                  //     .collection('users')
                                  //     .doc(currentUser.uid)
                                  //     .update({
                                  //   'police message':
                                  //       'Burglary/Theft Incident,\nSend Assistance.',
                                  // });
                                  final action = await AlertDialogs.yesCancelDialog(
                                      context,
                                      'Police Report',
                                      'Burglary/Theft Incident,\nSend Assistance.\n\nReport by:' +
                                          currentUser.email +
                                          '\nname : ' +
                                          name +
                                          '\nphone number : ' +
                                          phone);
                                }
                              },
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.lock,
                                          size: 40.0,
                                          color: Colors.yellowAccent,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            "BURGLARY/THEFT",
                                            style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    )),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Domestic Threat Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Domestic Threat Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.groups_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "DOMESTIC THREAT",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Sexual Assault Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Sexual Assault Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.priority_high_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "SEXUAL ASSULT",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Missing or Kidnapping Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Missing or Kidnapping Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.person_search_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "MISSING/KIDNAPPING",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'Terrorist Incident,\nSend Assistance.',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'Terrorist Incident,\nSend Assistance.\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.no_accounts_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "TERRORIST",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 163.0,
                        height: 100.0,
                        child: Card(
                          color: Colors.redAccent[700],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              var currentUser =
                                  FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final QuerySnapshot snap =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: currentUser.email)
                                        .get();
                                setState(() {
                                  name = snap.docs[0]['name'];
                                  phone = snap.docs[0]['phone'];
                                });
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(currentUser.uid)
                                //     .update({
                                //   'police message':
                                //       'In need of Police Assistance',
                                // });
                                final action = await AlertDialogs.yesCancelDialog(
                                    context,
                                    'Police Report',
                                    'In need of Police Assistance\n\nReport by:' +
                                        currentUser.email +
                                        '\nname : ' +
                                        name +
                                        '\nphone number : ' +
                                        phone);
                              }
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.outbond_rounded,
                                    size: 40.0,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "OTHERS",
                                      style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 340.0,
                        height: 70.0,
                        child: Card(
                            color: Colors.redAccent[700],
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: InkWell(
                              onTap: () async {
                                final action =
                                    await ConfirmViewMap.yesCancelDialog(
                                        context,
                                        'Closest Police Station',
                                        'What would you like to do?');
                              },
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.location_pin,
                                        size: 50.0,
                                        color: Colors.yellowAccent,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        child: Text("VIEW THE CLOSEST STATION",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.yellowAccent,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
