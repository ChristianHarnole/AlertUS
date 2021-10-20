import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "About Us",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "AlertUs is an Emergency Assistance Application developed by Computer Science students of Holy Angel University's School of Computing.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
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
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Aquino, Bea\n09420305903\naquinobea1999@gmail.com\n\nDizon, Maycee\n09070212544\nmaycee.g.dizon@gmail.com\n\nQuizon, Megan\n09186385668\nmeganraeq@gmail.com\n\nSerrano, Christian\n09633850455\nogihci321@gmail.com",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "***For Users who wish to register a station, kindly contact us for more details.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.start,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
