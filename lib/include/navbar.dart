// ignore_for_file: prefer_const_constructors

import 'package:attendance_nmsct/pages/dtr.dart';

import 'package:attendance_nmsct/pages/profile.dart';
import 'package:attendance_nmsct/pages/scan.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  // @override
  // void initState() {
  //   _getRecord();
  //   super.initState();
  // }

  // Future start() async {
  //   final snap = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .where('email', isEqualTo: user.email)
  //       .get();
  //   print(snap.docs[0]['email']);
  // }

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
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Users.names),
              accountEmail: Text(user.email!),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/leni.jpg',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('Homepage'),
            //   onTap: () {
            //   Navigator.of(context).pop(false);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const ScanScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: Text(Users.roles),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Attendance'),
              onTap: () {
                // Navigator.of(context).pop(false);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DTRScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Scan'),
              onTap: () {
                // Navigator.of(context).pop(false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScanScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigator.of(context).pop(false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.notifications),
            //   title: Text('Request'),
            // ),
            // Divider(),
            // ListTile(
            //   title: Text('Admin'),
            // ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('Establishment'),
            //   onTap: () {
            //     // Navigator.of(context).pop(false);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const EstablishmentScreen(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.description),
            //   title: Text('About'),
            //   onTap: () {
            //     // Navigator.of(context).pop(false);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const AboutScreen(),
            //       ),
            //     );
            //   },
            // ),
            Divider(),
            ListTile(
                title: Text('Log-out'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.of(context).pop(false);
                  logout();
                }),
          ],
        ),
      ),
    );
  }
}
