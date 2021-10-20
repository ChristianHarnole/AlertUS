import 'package:flutter/material.dart';

class RTPCRList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of RT-PCR Testing Sites",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: Center(
          child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                'High-Precision Diagnostics\nAddress: McArthur Hi-Way Corner Angeles Magalang, Road Santo Cristo Rd, Angeles\nEmail: pcr.angeles@hi-precision.com.ph\nWebsite: www.hi-precision.com.ph\nContact: (045) 322 2211\n  \nAngeles University Foundation Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nEmail: info@aufmc.com.ph\nWebsite: aufmc.com.ph\nContact: (045) 625 2999\n  \nAC Sacred Heart Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nEmail: sacredheartmedicalcenter@yahoo.com\nWebsite: acsacredheartmedicalcenter.com\nContact: (045) 624 5606\n  \nRafael Lazatin Memorial Medical Center (ONA)\nAddress: Visitacion St, Angeles, Pampanga\nContact: 0998 282 6259\n  \nSt. Catherine Of Alexandria Foundation and Medical Center\nAddress: Lot 5-6 Block 13 Rizal Extension, Brgy. Cutcut, Angeles, Pampanga\nEmail: scafmc.philippines@gmail.com\nContact: (045) 888 7209\n  \nSt. Catherine of Alexandria Foundation & Medical Center (New Site)\nAddress: Lot 5-6 Block 13 Rizal Extension Brgy, Angeles, Pampanga\nEmail: scafmc.philippines@gmail.com\nContact: 09189481097\n  \nPRI Medical Center, Angeles Medical Center Inc.\nAddress: Arayat Boulevard, Angeles City\nEmail: info@primconline.com\nWebsite: primedical.com.ph\nContact: 0917 180 8886\n  \nHoly Family Medical Center\nAddress: 1377 Santo Entiero St, Angeles, Pampanga\nContact: (045) 322 3623\n  \nDr. Armando Garcia Hospital\nAddress: 2196 Agapito Del Rosario Street, Angeles, Pampanga\nEmail: dalgmcinc.1971@gmail.com\nWebsite: dalgmcihospital.com\nContact: 0918 935 1052\n  \nAvanti Care Diagnostic Center\nAddress: 2401 Surla Street, Balibago, Angeles, Pampanga\nEmail: avanticarediagnosticcenter@gmail.com\nContact: 09352367728\n  \nSAVEPOINT (Sanitary Anti-Viral Entry Point)\nAddress: A-line Apartments, S. Rivera Lim, Balibago\nEmail: www.covidtestnow.savepoint.ph\nWebsite: savepoint.ph\nContact:\n+639565290826\n+639994633199\n  \nAstroClark Diagnostic Center\nAddress: 105 Zeppelin St, Balibago, Angeles, Pampanga\nEmail: astroclarkdiagnostic@gmail.com\nContact: 0963 995 7107\n  \nQuest Phil Diagnostics\nAddress: Salome St, Angeles, Pampanga\nEmail: questphilcovid.jbl@gmail.com\nWebsite: www.questphil.com.ph\nContact:\n0917-626-0911\n0917-535-9417\n0925-577-8378\n  \nAceMed Diagnostic Laboratory\nAddress: Teodoro St., Angeles City\nEmail: acemedlaboratory@gmail.com\nContact:\n0917 798 9993\n0999 888 7926\n  \nSingapore Diagnostics\nAddress: MacArthur Highway, San Pablo St, Angeles, Pampanga\nEmail: customercare@singaporediagnostics.com\nWebsite: www.singaporediagnostics.com\nContact: 0917 709 1577\n  \nMDLab Diagnostic Center Inc.\nAddress: Lot 23, Block 11, 1st Street, Balibago, Angeles City\nEmail: mdlab2311@yahoo.com\nWebsite: mdlab-diagnostic-center-incorporated.business.site\nContact:\n(045) 458 2614\n09324200799\n09334762398',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
