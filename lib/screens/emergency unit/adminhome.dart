// ignore_for_file: dead_code

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebasetest/main.dart';
import 'package:firebasetest/map%20screens/stationmap.dart';
import 'package:firebasetest/screens/emergency%20unit/firelistreports.dart';
import 'package:firebasetest/screens/emergency%20unit/hospitallistreports.dart';
import 'package:firebasetest/screens/emergency%20unit/policelistreports.dart';
import 'package:firebasetest/screens/user/homescreen.dart';
import 'package:firebasetest/screens/user/reportdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../contact lists/contactus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/user/confirmuser.dart';
import 'package:firebasetest/screens/user/mainscreen.dart';
import 'package:firebasetest/services/auth_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
_signOut() async {
  await _firebaseAuth.signOut();
}

class _MyAppState extends State<MyApp> {
  late String userTopic;
  late String token;
  List subscribed = [];
  List topics = ['Police', 'Hospital', 'Fire'];
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    getToken();
    getTopics();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  late String station;
  String userid = FirebaseAuth.instance.currentUser.uid;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //title: Text(""),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "Welcome",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              accountEmail: new Text("to AlertUs "),
              decoration: new BoxDecoration(color: Colors.redAccent[700]),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
              title: Text("Contact Us"),
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              onTap: () async {
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => ThisApp()),
                      (route) => false);
                }
              },
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'images/AlertUs.png',
              width: 120.0,
              height: 120.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "AlertUs",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Receive Notifications on Reports",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  topics[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: subscribed.contains(topics[index])
                    ? ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text("Stop Receiving Notifications"),
                                content: const Text(
                                    "Are you sure you want to unsubscribe to your station?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic(topics[index]);
                                      await FirebaseFirestore.instance
                                          .collection('topics')
                                          .doc(token)
                                          .update({
                                        topics[index]: FieldValue.delete()
                                      });
                                      setState(() {
                                        subscribed.remove(topics[index]);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('unsubscribe'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent[700],
                        ),
                        onPressed: () async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Receive Notifications"),
                                content: const Text(
                                    "Subscribing to other stations is not allowed\n\nYou are now subscribed to your assigned station. "),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                      var currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      if (currentUser != null) {
                                        final QuerySnapshot snap =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .where('email',
                                                    isEqualTo:
                                                        currentUser.email)
                                                .get();
                                        setState(() {
                                          station = snap.docs[0]['station'];
                                        });
                                        if (station == 'hospital') {
                                          await FirebaseMessaging.instance
                                              .subscribeToTopic(topics[1]);

                                          await FirebaseFirestore.instance
                                              .collection('topics')
                                              .doc(token)
                                              .set({topics[1]: 'subscribe'},
                                                  SetOptions(merge: true));
                                          setState(() {
                                            subscribed.add(topics[1]);
                                          });
                                        }
                                        if (station == 'police') {
                                          await FirebaseMessaging.instance
                                              .subscribeToTopic(topics[0]);

                                          await FirebaseFirestore.instance
                                              .collection('topics')
                                              .doc(token)
                                              .set({topics[0]: 'subscribe'},
                                                  SetOptions(merge: true));
                                          setState(() {
                                            subscribed.add(topics[0]);
                                          });
                                        }
                                        if (station == 'fire') {
                                          await FirebaseMessaging.instance
                                              .subscribeToTopic(topics[2]);

                                          await FirebaseFirestore.instance
                                              .collection('topics')
                                              .doc(token)
                                              .set({topics[2]: 'subscribe'},
                                                  SetOptions(merge: true));
                                          setState(() {
                                            subscribed.add(topics[2]);
                                          });
                                        }
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('subscribe'),
                      ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
            child: Text(
              "View Report Logs",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(spacing: 10, runSpacing: 5.0, children: <Widget>[
                SizedBox(
                  width: 360.0,
                  height: 70.0,
                  child: Card(
                      color: Colors.redAccent[700],
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        onTap: () async {
                          var currentUser = FirebaseAuth.instance.currentUser;

                          if (currentUser != null) {
                            final QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: currentUser.email)
                                .get();
                            setState(() {
                              station = snap.docs[0]['station'];
                            });
                            if (station == 'hospital') {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HospitalListReports()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Access Denied"),
                                    content: const Text(
                                        "You are not Authorized to view this Report Log"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.local_hospital_rounded,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Text("  HOSPITAL REPORT LOGS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                      )),
                ),
                SizedBox(
                  width: 360.0,
                  height: 70.0,
                  child: Card(
                      color: Colors.redAccent[700],
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        onTap: () async {
                          var currentUser = FirebaseAuth.instance.currentUser;

                          if (currentUser != null) {
                            final QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: currentUser.email)
                                .get();
                            setState(() {
                              station = snap.docs[0]['station'];
                            });
                            if (station == 'police') {
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

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PoliceListReports()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Access Denied"),
                                    content: const Text(
                                        "You are not Authorized to view this Report Log"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.local_police_rounded,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Text("  POLICE REPORT LOGS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                      )),
                ),
                SizedBox(
                  width: 360.0,
                  height: 70.0,
                  child: Card(
                      color: Colors.redAccent[700],
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        onTap: () async {
                          var currentUser = FirebaseAuth.instance.currentUser;

                          if (currentUser != null) {
                            final QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: currentUser.email)
                                .get();
                            setState(() {
                              station = snap.docs[0]['station'];
                            });
                            if (station == 'fire') {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FireListReports()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Access Denied"),
                                    content: const Text(
                                        "You are not Authorized to view this Report Log"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.fireplace_rounded,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Text("  FIRE REPORT LOGS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )),
                      )),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }

  getTopics() async {
    await FirebaseFirestore.instance
        .collection('topics')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (token == element.id) {
                subscribed = element.data().keys.toList();
              }
            }));

    setState(() {
      subscribed = subscribed;
    });
  }
}
