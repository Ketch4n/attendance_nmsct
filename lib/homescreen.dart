// ignore_for_file: prefer_const_constructors

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:attendance_nmsct/admin.dart';
import 'package:attendance_nmsct/admin_scan.dart';
import 'package:attendance_nmsct/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'include/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  double screenHeight = 0;
  double screenWidth = 0;

  // String ids = ' ';

  // int _selectedIndex = 1;

  // // ignore: prefer_final_fields
  // List<Widget> _widgetOptions = <Widget>[
  //   // LandingScreen(),
  //   DTRScreen(),
  //   ScanScreen(),
  //   ProfileScreen(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
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
              'Establishment',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              goAdmin();
            }),
        BottomSheetAction(
            title: const Text(
              'Section',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              goAdminScan();
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

  Future goAdminScan() async {
    Navigator.of(context).pop(false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminScanScreen()),
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
        drawer: NavbarScreen(),
        appBar: AppBar(title: Text('Homescreen')),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 180,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    'assets/images/attendance.png',
                    width: 100,
                  ),
                  Text(
                    DateFormat('EEEE').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: "NexaRegular",
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       left: 10,
                  //     ),
                  //     child: Text(
                  //       DateFormat(' MMMM yyyy').format(DateTime.now()),
                  //       style: TextStyle(
                  //         fontFamily: "NexaRegular",
                  //         fontSize: 20,
                  //         color: Colors.black,
                  //       ),
                  //       // style: TextStyle(
                  //       //   color: Colors.black,
                  //       //   fontSize: screenWidth / 20,
                  //       //   fontFamily: "NexaBold",
                  //       // ),
                  //     ),
                  //   ),
                  // ),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              DateFormat('MM/dd/yy -- hh:mm:ss  a')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontFamily: "NexaRegular",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),

            // Center(
            //   child: Row(
            //     children: <Widget>[],
            //   ),
            // ),
          ],
        ),

        // body: _widgetOptions.elementAt(_selectedIndex),
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: Colors.grey[200],
        //   // type: BottomNavigationBarType.fixed,
        //   items: const <BottomNavigationBarItem>[
        //     // BottomNavigationBarItem(
        //     //   icon: Icon(Icons.bar_chart),
        //     //   label: 'Role',
        //     // ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.calendar_today),
        //       label: 'DTR',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.qr_code_scanner_rounded),
        //       label: 'Scan',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   fixedColor: Colors.blue,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
