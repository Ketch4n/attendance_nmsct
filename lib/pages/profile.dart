// ignore_for_file: avoid_print

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:attendance_nmsct/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  // List<String> docID = [];

  // Future getdocID() async {
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((element) {
  //             print(element.reference);
  //             docID.add(element.reference.id);
  //           }));
  // }

  // @override
  // void initState() {
  //   getdocID();
  //   super.initState();
  // }
  Future bottomsheet() async {
    showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile Data'),
      androidBorderRadius: 20,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text(
              'Upload Profile Pic',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {}),
        BottomSheetAction(
            title: const Text(
              'Edit Details',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {}),
      ],
      // cancelAction: CancelAction(
      //     title: const Text(
      //   'CANCEL',
      //   style: TextStyle(fontSize: 18, fontFamily: "NexaBold"),
      // )), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  Future logout() async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(
              "Confirm Log out ?",
              style: TextStyle(color: Colors.red, fontFamily: "NexaBold"),
            ),
            content: const Text(
              'You will be required to login again next time',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          );
        });

    return value == true;
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
          child: const Icon(Icons.edit),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // drawer: NavbarScreen(),
        appBar: AppBar(title: const Text('Profile')),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 20),
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/leni.jpg',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                Users.names,
                style: const TextStyle(
                    fontFamily: "NexaBold", fontSize: 20, color: Colors.white),
              ),
            ),
            Text('ID : ${Users.card}'),

            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: UserAccountsDrawerHeader(
            //     accountName: Text('This'),
            //     accountEmail: Text(user.email!),
            //     currentAccountPicture: CircleAvatar(
            //       child: ClipOval(
            //         child: Image.asset(
            //           'assets/images/me.jpg',
            //           fit: BoxFit.cover,
            //           width: 90,
            //           height: 90,
            //         ),
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(10),
            //       ),
            //       color: Colors.blue,
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: NetworkImage(
            //             'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
            //       ),
            //     ),
            //   ),
            // )
            // Expanded(
            //   child: FutureBuilder(
            //       future: getdocID(),
            //       builder: (context, element) {
            //         return ListView.builder(
            //           itemCount: docID.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //                 title: GetScreen(documentID: docID[index]));
            //           },
            //         );
            //       }),
            // ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              height: 380,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Email : ${Users.emails}',
                            style: const TextStyle(
                                fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Address : ${Users.address}',
                            style: const TextStyle(
                                fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Contact Number : ',
                            style:
                                TextStyle(fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Birt Date : ',
                            style:
                                TextStyle(fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Course : ',
                            style:
                                TextStyle(fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Section : ',
                            style:
                                TextStyle(fontSize: 15, fontFamily: "NexaBold"),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
