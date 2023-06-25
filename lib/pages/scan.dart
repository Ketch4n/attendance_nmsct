// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'dart:async';

import 'package:attendance_nmsct/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  Color secondary = Colors.green;
  Color primary = Colors.blue;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Users")
          .where('email', isEqualTo: Users.ids)
          .get();
      // print(snap.docs[0].id);

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('Users')
          .doc(snap.docs[0].id)
          .collection('Record')
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }

    // print(checkIn);
    // print(checkOut);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.white])),
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan')),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: const EdgeInsets.only(top: 32),
              //   child: Text(
              //     "Welcome,",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontFamily: "NexaRegular",
              //       fontSize: screenWidth / 20,
              //     ),
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     "${Users.names}",
              //     style: TextStyle(
              //       fontFamily: "NexaBold",
              //       fontSize: screenWidth / 18,
              //     ),
              //   ),
              // ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 32, bottom: 20),
                child: Text(
                  "T O D A Y",
                  style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 13,
                      color: Colors.white),
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     text: DateFormat('EEEE').format(DateTime.now()),
              //     style: TextStyle(
              //       fontFamily: "NexaRegular",
              //       fontSize: screenWidth / 20,
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
              Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: DateFormat('MM/ ').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth / 18,
                      fontFamily: "NexaBold",
                    ),
                    children: [
                      TextSpan(
                        text: DateTime.now().day.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 18,
                          fontFamily: "NexaBold",
                        ),
                      ),
                      TextSpan(
                        text: DateFormat('/ yy').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 18,
                          fontFamily: "NexaBold",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('EEEE -- hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54,
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 10),
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Time-In",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            checkIn,
                            style: TextStyle(
                              fontFamily: "NexaBold",
                              fontSize: screenWidth / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Time-Out",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            checkOut,
                            style: TextStyle(
                              fontFamily: "NexaBold",
                              fontSize: screenWidth / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              checkOut == "--/--"
                  ? Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 12,
                      ),
                      child: Builder(
                        builder: (context) {
                          final GlobalKey<SlideActionState> key = GlobalKey();
                          return SlideAction(
                              text: checkIn == "--/--"
                                  ? "Slide to Time In"
                                  : "Slide to Check Out",
                              textStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth / 20,
                                fontFamily: "NexaRegular",
                              ),
                              outerColor: Colors.white,
                              innerColor: primary,
                              key: key,
                              onSubmit: () async {
                                Future.delayed(Duration(milliseconds: 500), () {
                                  key.currentState!.reset();
                                });
                                // Timer(const Duration(seconds: 1), () {

                                // });
                                // print(
                                //     DateFormat('hh:mm').format(DateTime.now()));
                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("Users")
                                    .where('email', isEqualTo: Users.ids)
                                    .get();
                                // print(snap.docs[0].id);

                                DocumentSnapshot snap2 = await FirebaseFirestore
                                    .instance
                                    .collection('Users')
                                    .doc(snap.docs[0].id)
                                    .collection('Record')
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .get();

                                try {
                                  String checkIn = snap2['checkIn'];
                                  setState(() {
                                    checkOut = DateFormat('hh:mm a')
                                        .format(DateTime.now());
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(snap.docs[0].id)
                                      .collection('Record')
                                      .doc(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()))
                                      .update({
                                    'date': Timestamp.now(),
                                    'checkIn': checkIn,
                                    'checkOut': DateFormat('hh:mm a')
                                        .format(DateTime.now()),
                                  });
                                } catch (e) {
                                  setState(() {
                                    checkIn = DateFormat('hh:mm a')
                                        .format(DateTime.now());
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(snap.docs[0].id)
                                      .collection('Record')
                                      .doc(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()))
                                      .set({
                                    'date': Timestamp.now(),
                                    'checkIn': DateFormat('hh:mm a')
                                        .format(DateTime.now()),
                                    'checkOut': checkOut,
                                  });
                                }
                                key.currentState!.reset();
                              });
                        },
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 32),
                      child: Text(
                        "You have completed this day!",
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// void get() {}
