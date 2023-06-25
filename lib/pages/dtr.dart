// ignore_for_file: library_private_types_in_public_api

import 'package:attendance_nmsct/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class DTRScreen extends StatefulWidget {
  const DTRScreen({Key? key}) : super(key: key);

  @override
  _DTRScreenState createState() => _DTRScreenState();
}

class _DTRScreenState extends State<DTRScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  // ignore: use_full_hex_values_for_flutter_colors
  Color primary = const Color(0xffeef444c);

  String _month = DateFormat('MMMM').format(DateTime.now());

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
        appBar: AppBar(
          title: const Text('Attendance'),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   margin: const EdgeInsets.only(top: 32),
              //   child: Text(
              //     "R E C O R D",
              //     style: TextStyle(
              //         fontFamily: "NexaBold",
              //         fontSize: screenWidth / 13,
              //         color: Colors.white),
              //   ),
              // ),

              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.only(top: 32, bottom: 20, left: 15),
                    child: Text(
                      _month,
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 25, right: 15),
                    child: GestureDetector(
                      onTap: () async {
                        final month = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2099),
                        );

                        if (month != null) {
                          setState(() {
                            _month = DateFormat('MMMM').format(month);
                          });
                        }
                      },
                      child: const Icon(
                        Icons.calendar_today_rounded,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: screenHeight - screenHeight / 3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(Users.ids)
                      .collection('Record')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return DateFormat('MMMM')
                                      .format(snap[index]['date'].toDate()) ==
                                  _month
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: index > 0 ? 12 : 0,
                                      bottom: 6,
                                      left: 6,
                                      right: 6),
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 20,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          DateFormat('EE\ndd').format(
                                              snap[index]['date'].toDate()),
                                          style: const TextStyle(
                                              fontFamily: "NexaBold",
                                              fontSize: 20,
                                              color: Colors.white),
                                        )),
                                      )),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              snap[index]['checkIn'],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              snap[index]['checkOut'],
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
                                )
                              : const SizedBox();
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),

              // child: Text(
              //   "Pick a Month",
              //   style: TextStyle(
              //     fontFamily: "NexaBold",
              //     fontSize: screenWidth / 18,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
