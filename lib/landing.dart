// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'admin.dart';
import 'admin_scan.dart';
import 'admin_section.dart';
import 'include/admin_navbar.dart';
import 'model/user.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    getID();
    _getRecord();
  }

  void getID() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user.email)
        .get();

    setState(() {
      Users.ids = snap.docs[0].id;
    });
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Users")
          .where('email', isEqualTo: user.email)
          .get();
      // print(snap.docs[0].id);

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('Users')
          .doc(snap.docs[0].id)
          .get();

      // print(snap2['name']);

      setState(() {
        Users.names = snap2['name'];
        Users.emails = snap2['email'];
        Users.card = snap2['card'];
        Users.roles = snap2['role'];
        Users.address = snap2['address'];
        Users.birth = snap2['birth'];
      });
      // ignore: empty_catches
    } catch (e) {}

    // print(checkIn);
    // print(checkOut);
  }

  Future bottomsheet() async {
    showAdaptiveActionSheet(
      context: context,
      title: Text('Establishment and Section'),
      androidBorderRadius: 20,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text(
              'Generate QR',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              goAdmin();
            }),
        BottomSheetAction(
            title: const Text(
              'Create Section',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              goAdminSection();
            }),
      ],
      // cancelAction: CancelAction(
      //     title: const Text(
      //   'CANCEL',
      //   style: TextStyle(fontSize: 18, fontFamily: "NexaBold"),
      // )), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  Future goAdmin() async {
    Navigator.of(context).pop(false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminScreen()),
    );
  }

  // Future goAdminScan() async {
  //   Navigator.of(context).pop(false);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const AdminScanScreen()),
  //   );
  // }
  Future goAdminSection() async {
    Navigator.of(context).pop(false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminSection()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.white])),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bottomsheet();
          },
          child: Icon(Icons.add),
        ),
        drawer: AdminNavBar(),
        appBar: AppBar(title: Text('Administrator')),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 105,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "QR codes",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 132),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300.0),
                              color: Colors.blueAccent),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                'assets/images/qr.png',
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 105,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Your Section",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 110),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300.0),
                              color: Colors.blueAccent),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                'assets/images/admin.png',
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
