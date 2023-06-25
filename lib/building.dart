import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'include/building_navbar.dart';
import 'model/user.dart';

class Building extends StatefulWidget {
  const Building({super.key});

  @override
  State<Building> createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.white])),
      child: Scaffold(
        drawer: const BuildingNavbar(),
        appBar: AppBar(title: const Text('Establishment')),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'assets/images/estab.png',
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Users.names,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ],
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
                              "Present Today",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ],
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
