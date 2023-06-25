// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:attendance_nmsct/auth/create.dart';
import 'package:attendance_nmsct/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Color secondary = Colors.green;
  Color primary = Colors.blue;

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      (e);
      showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: "Account not found",
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future forgotpass() async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Coming Soon !",
              style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
            ),
            content: Text(
              'currently under construction',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
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

    return value == true;
  }

  Future create() async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Create New Account ?",
              style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
            ),
            // content: Text(
            //   'click Sign Up to Continue',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateScreen()),
                  );
                },
              ),
            ],
          );
        });

    return value == true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  "Confirm Exit",
                  style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
                ),
                content: Text(
                  'Are you sure you want to exit ?',
                  style:
                      TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
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
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    isKeyboardVisible
                        ? Container(
                            height: 20,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/images/face.png',
                              ),
                            ),
                          ),
                    isKeyboardVisible
                        ? SizedBox(height: 0)
                        : Text(
                            "Attendance",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "NexaBold",
                                color: Colors.white),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "NexaBold",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        // style: TextStyle(fontSize: 15),
                        controller: _emailController,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // prefixIcon: const Icon(
                          //   Icons.person,
                          //   color: Colors.blueGrey,
                          // ),
                          hintText: 'Email',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        // style: TextStyle(fontSize: 18),
                        // obscureText: true,
                        obscureText: _isObscure,
                        enableSuggestions: false,
                        controller: _passController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // prefixIcon: const Icon(
                          //   Icons.key_sharp,
                          //   color: Colors.blueGrey,
                          // ),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          String email = _emailController.text.trim();
                          String password = _passController.text.trim();

                          if (email.isEmpty) {
                            // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Email !"),
                            //     duration: Duration(seconds: 2),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Enter Email",
                              ),
                            );
                          } else if (password.isEmpty) {
                            // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Please Enter Password !"),
                            //     // backgroundColor: Colors.teal,
                            //     duration: Duration(seconds: 2),
                            //   ),
                            // );
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Enter Password",
                              ),
                            );
                          } else {
                            signIn();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "NexaBold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     fieldTitle("Log in as "),
                    //     GestureDetector(
                    //       onTap: admin,
                    //       child: Text(
                    //         "Administrator",
                    //         style: TextStyle(
                    //             color: Colors.blue, fontFamily: "NexaBold"),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // fieldTitle(" or "),

                    GestureDetector(
                      child: isKeyboardVisible
                          ? GestureDetector(
                              onTap: forgotpass,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "NexaBold"),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: create,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Text(
                                  "Create new Account ?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "NexaBold"),
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
      ),
    );
  }

  // bool _keyboardIsVisible() {
  //   return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  // }

  // Widget fieldTitle(String title) {
  //   return Text(
  //     title,
  //     style: TextStyle(fontFamily: "NexaRegular"),
  //   );
  // }
}
