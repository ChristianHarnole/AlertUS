import 'package:firebasetest/contact%20lists/firestationlist.dart';
import 'package:firebasetest/contact%20lists/hospitallist.dart';
import 'package:firebasetest/contact%20lists/policelist.dart';
import 'package:flutter/material.dart';

class EmergencyContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency Unit Contacts",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "List of Emergency Contacts",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalList()),
                    );
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.list_rounded,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text("\t\t\tHospital List",
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
                ),
              ),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PoliceList()),
                      );
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.list_rounded,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text("\t\t\tPolice Station List",
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FireStationList()),
                      );
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.list_rounded,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text("\t\t\tFire Station List",
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
          ])),
    );
  }
}
