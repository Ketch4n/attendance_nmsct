// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, prefer_final_fields, use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:math';

import '../main.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  static final _formKey = new GlobalKey<FormState>();

  bool _isObscure = true;
  String selectedValue = "Student";

  /// just  define _formkey with static fina
  Key _k1 = new GlobalKey();
  Key _k2 = new GlobalKey();
  // Key _k3 = new GlobalKey();
  // Key _k4 = new GlobalKey();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _studentController = TextEditingController();
  var _roleController = TextEditingController();
  final _nameController = TextEditingController();
  // final _lnameController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  Color secondary = Colors.green;
  Color primary = Colors.blue;

  final inputController = StreamController<String>();

  String generateId() {
    var random = Random();
    return random.nextInt(999999999).toString();
  }

  Future login() async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Go back to Login ?",
              style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
            ),
            // content: Text(
            //   'click ok to continue',
            //   style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            // ),
            actions: <Widget>[
              // TextButton(
              //   child: Text('No'),
              //   onPressed: () {
              //     Navigator.of(context).pop(false);
              //   },
              // ),
              TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    Navigator.pop(context);
                  }),
            ],
          );
        });

    return value == true;
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );
      // FirebaseAuth.instance.signOut();
      // Navigator.of(context).pop(false);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      message_sign();
      details(
        _studentController.text.trim(),
        _nameController.text.trim(),
        selectedValue.trim(),
        _emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      (e);
      message_error();
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.info(
      //     message: "Account not found",
      //   ),
      // );
    }
  }

  Future details(
    String student,
    String name,
    String selectedValue,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('Users').doc(email).set({
      'card': student,
      'name': name,
      'role': selectedValue,
      'email': email,
    });
  }

  Future message_sign() async {
    await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "SUCCESS !",
              style: TextStyle(color: Colors.green, fontFamily: "NexaBold"),
            ),
            content: Text(
              'new account created',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(false);
                },
              ),
              // TextButton(
              //   child: Text('Yes'),
              //   onPressed: () {
              //     Navigator.of(context).pop(false);
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //       builder: (context) => const AdminScreen()),
              //     // );
              //   },
              // ),
            ],
          );
        });
  }

  Future message_error() async {
    await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "INVALID",
              style: TextStyle(color: Colors.red, fontFamily: "NexaBold"),
            ),
            content: Text(
              'Account already taken',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);
                },
              ),
              // TextButton(
              //   child: Text('Yes'),
              //   onPressed: () {
              //     Navigator.of(context).pop(false);
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //       builder: (context) => const AdminScreen()),
              //     // );
              //   },
              // ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _studentController.dispose();
    _roleController.dispose();
    _nameController.dispose();
    // _lnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  "Go back to Login ?",
                  style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
                ),
                // content: Text(
                //   'click ok to continue',
                //   style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
                // ),
                actions: <Widget>[
                  // TextButton(
                  //   child: Text('No'),
                  //   onPressed: () {
                  //     Navigator.of(context).pop(false);
                  //   },
                  // ),
                  TextButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        Navigator.pop(context);
                      }),
                ],
              );
            });

        return value == true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueGrey, Colors.white])),
          child: Scaffold(
            key: _formKey,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,

                  children: [
                    _keyboardIsVisible()
                        ? SizedBox(height: 0)
                        : Padding(
                            padding: const EdgeInsets.only(top: 50),
                            // child: Image.asset(
                            //   'assets/images/attendance.png',
                            //   width: screenWidth / 3,
                            // ),
                          ),
                    _keyboardIsVisible()
                        ? SizedBox(height: 0)
                        : Text(
                            "Create New Account",
                            style: TextStyle(
                                fontSize: screenWidth / 15,
                                fontFamily: "NexaBold",
                                color: Colors.white),
                          ),
                    _keyboardIsVisible()
                        ? SizedBox(height: 30)
                        : Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 10),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: screenWidth / 18,
                                fontFamily: "NexaBold",
                              ),
                            ),
                          ),
                    // SizedBox(height: 5),
                    // _keyboardIsVisible()
                    //     ?
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),

                        value: selectedValue,
                        hint: Text("Role"),

                        // ignore: prefer_const_literals_to_create_immutables
                        items: [
                          //add items in the dropdown
                          DropdownMenuItem(
                            value: "Student",
                            child: Text("Student"),
                          ),
                          DropdownMenuItem(
                              value: "Admin", child: Text("Admin")),
                          DropdownMenuItem(
                            value: "Establishment",
                            child: Text("Establishment"),
                          )
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            inputController.add(newValue);
                            _studentController.clear();
                          });
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: StreamBuilder<String>(
                          stream: inputController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.data == 'Establishment') {
                              return TextField(
                                enableSuggestions: false,
                                controller: _studentController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Location',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              );
                            } else {
                              return TextField(
                                enableSuggestions: false,
                                controller: _studentController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'ID',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () {
                                        String id = generateId();
                                        _studentController.text = id;
                                      }),
                                ),
                              );
                            }
                          }),
                    ),
                    //     : SizedBox(height: 5),
                    // _keyboardIsVisible()
                    //     ?

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        enableSuggestions: false,
                        controller: _nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Name',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                    // SizedBox(height: 10),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: TextField(
                    //     enableSuggestions: false,
                    //     controller: _roleController,
                    //     decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.white),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.green),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       hintText: 'Role',
                    //       fillColor: Colors.grey[200],
                    //       filled: true,
                    //       suffixIcon: const Icon(
                    //         Icons.keyboard_arrow_down_sharp,
                    //         // color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        key: _k1,
                        controller: _emailController,
                        enableSuggestions: false,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Email',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        key: _k2,
                        obscureText: _isObscure,
                        enableSuggestions: false,
                        controller: _passController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Minimum of 6 characters'
                            : null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                        ),
                      ),
                    ),

                    // : SizedBox(height: 0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          String student = _studentController.text.trim();
                          String name = _nameController.text.trim();
                          String role = selectedValue.trim();
                          String email = _emailController.text.trim();
                          String password = _passController.text.trim();

                          // String lname = _lnameController.text.trim();

                          if (student.isEmpty) {
                            // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Student ID !"),
                            //     duration: Duration(milliseconds: 500),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Input required data",
                              ),
                            );
                          } else if (name.isEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Section !"),
                            //     // backgroundColor: Colors.teal,
                            //     duration: Duration(milliseconds: 500),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Please Enter Name",
                              ),
                            );
                          } else if (role.isEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Section !"),
                            //     // backgroundColor: Colors.teal,
                            //     duration: Duration(milliseconds: 500),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Pleae Select Role",
                              ),
                            );
                          }
                          // else if (section.isEmpty) {
                          //   // ScaffoldMessenger.of(context).showSnackBar(
                          //   //   const SnackBar(
                          //   //     content: Text("Please Enter Section !"),
                          //   //     // backgroundColor: Colors.teal,
                          //   //     duration: Duration(milliseconds: 500),
                          //   //   ),
                          //   // );
                          //   showTopSnackBar(
                          //     context,
                          //     CustomSnackBar.info(
                          //       message: "Select Role",
                          //     ),
                          //   );
                          // }
                          else if (email.isEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Email !"),
                            //     // backgroundColor: Colors.teal,
                            //     duration: Duration(milliseconds: 500),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Please Enter Email",
                              ),
                            );
                          } else if (password.isEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Password !"),
                            //     // backgroundColor: Colors.teal,
                            //     duration: Duration(milliseconds: 500),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Please Enter Password",
                              ),
                            );
                          } else {
                            signUp();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "NexaBold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: login,
                      child: _keyboardIsVisible()
                          ? SizedBox(height: 0)
                          : Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Text(
                                "Already have an Account ?",
                                style: TextStyle(
                                    color: Colors.blue, fontFamily: "NexaBold"),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
  // Widget fieldTitle(String title) {
  //   return Text(
  //     title,
  //     style: TextStyle(fontFamily: "NexaRegular"),
  //   );
  // }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(value: "Student", child: Text("Student")),
    DropdownMenuItem(value: "Admin", child: Text("Admin")),
    DropdownMenuItem(value: "Establishment", child: Text("Establishment")),
  ];
  return menuItems;
}
