import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile.dart';
import 'profilesignup.dart';
import 'package:email_auth/email_auth.dart';

class ConfirmUserSignup extends StatefulWidget {
  @override
  _ConfirmUserSignup createState() => _ConfirmUserSignup();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
_signOut() async {
  await _firebaseAuth.signOut();
}

class _ConfirmUserSignup extends State<ConfirmUserSignup> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  String email = " ";
  String uid = " ";
  String role = " ";
  String password = " ";
  String name = " ";
  String phone = " ";
  String errorMessage = '';
  bool isLoading = false;

  //final _formkey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  validator() {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  bool ableToEdit = false;

  void sendOTP() async{
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(
      receiverMail: emailController.text);
    if (res){
      print ("OTP Sent");
    }else{
      print("We could not send the OTP");
    }
  }

  void verifyOTP() async {
    try{
    var res = EmailAuth.validate(
      receiverMail: emailController.text, 
      userOTP: otpController.text);
      if(res){
        print("OTP Verified");
        errorMessage = res.toString();
      }else{
        print("Invalid OTP");
        errorMessage = res.toString();
      }
    }catch (e){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Confirmation"),
          ),
          backgroundColor: Colors.redAccent[700],
        ),
        backgroundColor: Colors.orange[200],
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FittedBox(
                        child: Text(
                          "Please confirm your email first,\nAfter confirming your email, set Profile Data",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey[400],
                          ),
                          suffixIcon: TextButton(
                            child: Text("Send OTP"),
                            onPressed: () {
                              String userEmail = emailController.text.trim();
                              if (_formkey.currentState!.validate()){
                                sendOTP();
                              }
                            },
                          )
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().length == 0) {
                            return "Email Required";
                          }

                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please Enter valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: otpController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                              fillColor: Colors.white,
                          filled: true,
                          hintText: "OTP",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )),
                ),
                    GestureDetector(
                      onTap: () async{
                        String userEmail = emailController.text.trim();
                        String userOTP = otpController.text.trim();
                        /*
                        verifyOTP();
                        validator();
                        if (userEmail.isEmpty) {
                          validator();
                        } else {
                          final QuerySnapshot snap = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .where('email', isEqualTo: userEmail)
                              .get();
                          setState(() {
                            email = userEmail;
                            uid = snap.docs[0]['uid'];
                            role = snap.docs[0]['role'];
                            name = snap.docs[0]['name'];
                            phone = snap.docs[0]['phone'];

                            ableToEdit = true;
                          });
                        }
                        */
                        setState(() {
                          isLoading = true;
                          errorMessage = '';
                        });

                        try{
                          verifyOTP();
                          if (userEmail.isEmpty) {
                          validator();
                        } else {
                          final QuerySnapshot snap = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .where('email', isEqualTo: userEmail)
                              .get();
                          setState(() {
                            email = userEmail;
                            uid = snap.docs[0]['uid'];
                            role = snap.docs[0]['role'];
                            name = snap.docs[0]['name'];
                            phone = snap.docs[0]['phone'];

                            ableToEdit = true;
                          });
                        }
                        }catch (error){
                          errorMessage = error.toString();
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.redAccent[700],
                        ),
                        child: Center(
                          child: Text("Verify OTP",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     await _signOut();
                    //     if (_firebaseAuth.currentUser == null) {
                    //       Navigator.of(context).pushAndRemoveUntil(
                    //           MaterialPageRoute(builder: (c) => ThisApp()),
                    //           (route) => false);
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: 100,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       color: Colors.redAccent[700],
                    //     ),
                    //     child: Center(
                    //       child: Text("Cancel",
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             color: Colors.white,
                    //           )),
                    //     ),
                    //   ),
                    // ),
                    ableToEdit
                        ? GestureDetector(
                            onTap: () {
                              validator();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileSignUp(
                                            uid: uid,
                                          )));
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.redAccent[700],
                              ),
                              child: Center(
                                child: Text("Set Profile",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
