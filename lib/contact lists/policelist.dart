import 'package:flutter/material.dart';

class PoliceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Police Stations",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: Center(
          child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                'Police Station 1\nAddress: Santo Rosario St, Angeles, Pampanga\nContact: 0998-598-5526\n  \nPolice Station 2\nAddress: Richthofen St, Angeles, 2009 Pampanga\nContact: 0998-598-5528\n  \nPolice Station 3\nAddress: Pandan Rd, Angeles, Pampanga\nContact: 0998-598-5530\n  \nPolice Station 4\nAddress: M.A Roxas Hwy, Cor Constine, Baudago, Angeles, Pampanga\nContact: 0998-598-5532\n  \nPolice Station 5\nAddress: Fil-Am Friendship Hwy, Angeles, Pampanga\nContact: 0998-598-5536\n  \nPolice Station 6\nAddress: Jake Gonzales Blvd, Angeles, Pampanga\nContact: 0998-598-5538',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
