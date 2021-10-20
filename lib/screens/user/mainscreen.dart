// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasetest/services/auth_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController phoneController = new TextEditingController();

//   //final _formkey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String errorMessage = '';
//   String errorCode = '';
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.orange[200],
//       body: Container(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: 20.0),
//                 Container(
//                   height: 250,
//                   child: Image(
//                     image: AssetImage("images/AlertUs.png"),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 RichText(
//                     text: TextSpan(
//                         text: 'Welcome to ',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                         children: <TextSpan>[
//                       TextSpan(
//                           text: 'AlertUs',
//                           style: TextStyle(
//                               fontSize: 30.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red[900]))
//                     ])),
//                 SizedBox(height: 10.0),
//                 Text(
//                   'An Emergency Assistance Application\n',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 50,
//                   ),
//                   child: TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: emailController,
//                     // Blacklist/ Filtering of Space Input
//                     /*
//                     inputFormatters: [
//                       FilteringTextInputFormatter.deny(RegExp('[ ]'))
//                     ],
//                     */
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none),
//                       fillColor: Colors.white,
//                       filled: true,
//                       hintText: "E-Mail...",
//                       prefixIcon: Icon(
//                         Icons.email,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                     validator: (String? value) {
//                       if (value == null || value.trim().length == 0) {
//                         return "Email Required";
//                       }
//                       if (value.contains(" ")) {
//                         return "Spacing is not allowed";
//                       }
//                       if (!RegExp(
//                           //Meaning = \AlphaNumericWord\ @ \AlphaNumericWord\ . \AlphaNumericWord
//                           r'\w+@\w+\.\w+').hasMatch(value)) {
//                         return "Please Enter valid email address";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                     errorMessage,
//                     style: TextStyle(color: Colors.red),
//                   )),
//                 ),
//                 SizedBox(height: 1),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 50,
//                   ),
//                   child: TextFormField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none),
//                       fillColor: Colors.white,
//                       filled: true,
//                       hintText: "Password...",
//                       prefixIcon: Icon(
//                         Icons.lock,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                     obscureText: true,
//                     validator: (String? value) {
//                       if (value == null || value.trim().length == 0) {
//                         return "Password is required";
//                       }
//                       if (value.length < 8) {
//                         return "Password should not be less than 8 characters";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                     errorCode,
//                     style: TextStyle(color: Colors.red),
//                   )),
//                 ),
//                 SizedBox(height: 1),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width / 3,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     color: Colors.redAccent[700],
//                   ),
//                   child: FlatButton(
//                     onPressed: () async {
//                       final String email = emailController.text.trim();
//                       final String password = passwordController.text.trim();

//                       setState(() {
//                         isLoading = true;
//                         errorCode = '';
//                       });

//                       if (_formkey.currentState!.validate()) {
//                         try {
//                           await FirebaseAuth.instance
//                               .signInWithEmailAndPassword(
//                             email: email,
//                             password: password,
//                           );
//                         } on FirebaseAuthException catch (error) {
//                           errorCode = error.code!;
//                         }
//                         setState(() => isLoading = false);
//                       }
// /*
//                       setState(() {
//                         if (_formkey.currentState!.validate()){
//                            context.read<AuthService>().login(
//                                 email,
//                                 password,
//                               );
//                         }
//                       });
// */
//                     },
//                     child: Text("Log In",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width / 3,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     color: Colors.redAccent[700],
//                   ),
//                   child: FlatButton(
//                     onPressed: () async {
//                       final String email = emailController.text.trim();
//                       final String password = passwordController.text.trim();
//                       setState(() {
//                         isLoading = true;
//                         errorMessage = '';
//                       });

//                       if (_formkey.currentState!.validate()) {
//                         try {
//                           await FirebaseAuth.instance
//                               .createUserWithEmailAndPassword(
//                             email: email,
//                             password: password,
//                           );
//                         } on FirebaseAuthException catch (error) {
//                           errorMessage = error.message!;
//                         }
//                         setState(() => isLoading = false);
//                       }
//                     },
//                     child: Text("Sign Up",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  //final _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String errorMessage = '';
  String errorCode = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[200],
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  height: 250,
                  child: Image(
                    image: AssetImage("images/AlertUs.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: 'AlertUs',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900]))
                    ])),
                SizedBox(height: 10.0),
                Text(
                  'An Emergency Assistance Application\n',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    // Blacklist/ Filtering of Space Input
                    /*
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]'))
                    ],
                    */
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "E-Mail...",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[400],
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().length == 0) {
                        return "Email Required";
                      }
                      if (value.contains(" ")) {
                        return "Spacing is not allowed";
                      }
                      if (!RegExp(
                          //Meaning = \AlphaNumericWord\ @ \AlphaNumericWord\ . \AlphaNumericWord
                          r'\w+@\w+\.\w+').hasMatch(value)) {
                        return "Please Enter valid email address";
                      }
                      return null;
                    },
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
                SizedBox(height: 1),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password...",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[400],
                      ),
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null || value.trim().length == 0) {
                        return "Password is required";
                      }
                      if (value.length < 8) {
                        return "Password should not be less than 8 characters";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    errorCode,
                    style: TextStyle(color: Colors.red),
                  )),
                ),
                SizedBox(height: 1),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent[700],
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      setState(() {
                        isLoading = true;
                        errorCode = '';
                      });

                      if (_formkey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        } on FirebaseAuthException catch (error) {
                          errorCode = error.code!;
                        }
                        setState(() => isLoading = false);
                      }
/*
                      setState(() {
                        if (_formkey.currentState!.validate()){
                           context.read<AuthService>().login(
                                email,
                                password,
                              );
                        }
                      });
*/
                    },
                    child: Text("Log In",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent[700],
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();
                      setState(() {
                        isLoading = true;
                        errorMessage = '';
                      });

                      if (_formkey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          )
                              .then((value) async {
                            User user = FirebaseAuth.instance.currentUser;

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.uid)
                                .set({
                              'uid': user.uid,
                              'email': email,
                              'password': password,
                              'role': 'user',
                              'name': 'Name',
                              'phone': '00000000000',
                              'police message': '',
                              'hospital message': '',
                              'fire message': '',
                              'longitude': 0,
                              'latitude': 0,
                            });
                          });
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                        }
                        setState(() => isLoading = false);
                      }
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
