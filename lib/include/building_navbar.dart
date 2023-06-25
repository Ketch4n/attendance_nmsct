import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../about.dart';
import '../establishment.dart';
import '../model/user.dart';

class BuildingNavbar extends StatefulWidget {
  const BuildingNavbar({super.key});

  @override
  State<BuildingNavbar> createState() => _BuildingNavbarState();
}

class _BuildingNavbarState extends State<BuildingNavbar> {
  final user = FirebaseAuth.instance.currentUser!;
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
                    'assets/images/estab.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
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
            // ListTile(
            //   leading: const Icon(Icons.calendar_today),
            //   title: const Text('Attendance'),
            //   onTap: () {
            //     // Navigator.of(context).pop(false);

            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const DTRScreen(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.qr_code),
            //   title: const Text('Scan'),
            //   onTap: () {
            //     // Navigator.of(context).pop(false);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const ScanScreen(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.person),
            //   title: const Text('Profile'),
            //   onTap: () {
            //     // Navigator.of(context).pop(false);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const ProfileScreen(),
            //       ),
            //     );
            //   },
            // ),
            // // ListTile(
            // //   leading: Icon(Icons.notifications),
            // //   title: Text('Request'),
            // // ),
            // const Divider(),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('All Student'),
              onTap: () {
                // Navigator.of(context).pop(false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EstablishmentScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Account'),
              onTap: () {
                // Navigator.of(context).pop(false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(),
                  ),
                );
              },
            ),

            const Divider(),
            ListTile(
                title: const Text('Log-out'),
                leading: const Icon(Icons.exit_to_app),
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
