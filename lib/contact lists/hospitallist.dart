import 'package:flutter/material.dart';

class HospitalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Hospitals",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: Center(
          child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                'Angeles University Foundation Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nEmail: info@aufmc.com.ph\nWebsite: aufmc.com.ph\nContact: (045) 625 2999\n  \nAC Sacred Heart Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nEmail: sacredheartmedicalcenter@yahoo.com\nWebsite: acsacredheartmedicalcenter.com\nContact: (045) 624 5606\n  \nRafael Lazatin Memorial Medical Center (ONA)\nAddress: Visitacion St, Angeles, Pampanga\nContact: 0998 282 6259\n  \nSt. Catherine Of Alexandria Foundation and Medical Center\nAddress: Lot 5-6 Block 13 Rizal Extension, Brgy. Cutcut, Angeles City, Pampanga\nEmail: scafmc.philippines@gmail.com\nContact: (045) 888 7209\n  \nSt. Catherine of Alexandria Foundation & Medical Center (New Site)\nAddress: Lot 5-6 Block 13 Rizal Extension, Angeles, Pampanga\nEmail: scafmc.philippines@gmail.com\nContact: 09189481097\n  \nPRI Medical Center, Angeles Medical Center Inc.\nAddress: Arayat Boulevard, Angeles, Pampanga\nEmail: info@primconline.com\nWebsite: primedical.com.ph\nContact: 0917 180 8886\n  \nAngeles Medical Center Inc.\nAddress: 641 Rizal St, Angeles, Pampanga\nEmail: marketing@angelesmed.com\nWebsite: www.angelesmed.com\nContact: (045) 322 4632\n  \nHoly Family Medical Center\nAddress: 1377 Santo Entiero St, Angeles, Pampanga\nContact: (045) 322 3623\n  \nDr. Armando Garcia Hospital\nAddress: 2196 Agapito Del Rosario Street, Angeles, Pampanga\nEmail: dalgmcinc.1971@gmail.com\nWebsite: dalgmcihospital.com\nContact: 0918 935 1052',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
