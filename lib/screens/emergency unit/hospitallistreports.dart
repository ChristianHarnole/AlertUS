import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/emergency%20unit/reportoptiondialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HospitalListReports extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _HospitalListReports createState() => _HospitalListReports();
}

class _HospitalListReports extends State<HospitalListReports> {
  @override
  Widget build(BuildContext context) {
    late String yourUid;
    return Scaffold(
        appBar: new AppBar(
          title: Text("Report Logs"),
          backgroundColor: Colors.redAccent[700],
        ),
        backgroundColor: Colors.orange[200],
        body: StreamBuilder<QuerySnapshot>(
          stream: widget._firestore.collection('hospital reports').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading..');
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String itemTitle =
                      snapshot.data!.docs[index]['hospital message'];
                  String itemSubtitle =
                      snapshot.data!.docs[index]['createdOn'].toString();
                  return Slidable(
                      child: CardItem(
                        itemTitle: itemTitle,
                        itemSubtitle: itemSubtitle,
                      ),
                      actionPane: SlidableDrawerActionPane(),

                      //left side
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete_outline_rounded,
                          onTap: () async {
                            return await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you wish to delete this report?\n\nOnce you delete this report,It will no longer exist in the report log and will be considered as a COMPLETED REPORT."),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () async {
                                          final QuerySnapshot snap =
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'hospital reports')
                                                  .where('hospital message',
                                                      isEqualTo: itemTitle)
                                                  .get();
                                          setState(() {
                                            yourUid = snap.docs[0]['uid'];
                                          });

                                          FirebaseFirestore.instance
                                              .collection("hospital reports")
                                              .doc(yourUid)
                                              .delete();

                                          Navigator.of(context).pop();

                                          // setState(() {});
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           HospitalListReports()),
                                          // );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HospitalListReports()),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: const Text("DELETE")),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("CANCEL"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ]);
                });
          },
        ));
  }
}

class CardItem extends StatefulWidget {
  String itemTitle;
  String itemSubtitle;
  CardItem({required this.itemTitle, required this.itemSubtitle});
  @override
  _CardItem createState() => _CardItem(itemTitle, itemSubtitle);
}

class _CardItem extends State<CardItem> {
  String itemTitle;
  String itemSubtitle;
  _CardItem(this.itemTitle, this.itemSubtitle);
  late String yourUid;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[800],
      child: ListTile(
        title: Text(
          widget.itemTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.itemSubtitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('hospital reports')
              .where('hospital message', isEqualTo: itemTitle)
              .get();
          setState(() {
            yourUid = snap.docs[0]['uid'];
          });

          var currentUser = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({
            'report id': yourUid,
          });

          final action = await ReportOptionDialog.yesCancelDialog(
              context,
              'View Map',
              'Kindly press DONE once you are finished viewing the map.\n\nThis will end the current session');
        },
      ),
    );
  }
}
