import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/screens/user/homescreen.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String uid;

  Profile({Key? key, required this.uid}) : super(key: key);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Profile"),
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      "Please fill in the form below\n these data will be sent to emergency units",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Name...",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey[400],
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().length == 0) {
                        return "Field Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone...(e.g. 09228631973)",
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey[400],
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().length == 0) {
                        return "Field is required";
                      }
                      if (value.length < 11) {
                        return "Phone number should not be less than 11 characters";
                      }
                      if (value.length > 11) {
                        return "Phone number should not be more than 11 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String newName = nameController.text.trim();
                      String newPhone = phoneController.text.trim();

                      setState(() {
                        if (_formkey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.uid)
                              .update({
                            'name': newName,
                            'phone': newPhone,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent[700],
                      ),
                      child: Center(
                        child: Text(
                          "UPDATE PROFILE",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
