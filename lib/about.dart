import 'package:attendance_nmsct/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueGrey, Colors.white])),
        child: Scaffold(
          appBar: AppBar(title: const Text('One User')),
          backgroundColor: Colors.transparent,
          body: FutureBuilder<User2?>(
            future: readUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong ${snapshot.error}');
              } else if (snapshot.hasData) {
                final user = snapshot.data;
                return user == null
                    ? const Center(child: Text('NO USER'))
                    : buildUser(user);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
  Widget buildUser(User2 user) => ListTile(
        leading: const CircleAvatar(
            // child: Text('${user.id}')
            ),
        title: Text(user.name),
        subtitle: Text(user.email),
      );
  Future<User2?> readUser() async {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(Users.ids);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User2.fromJson(snapshot.data()!);
    }
    return null;
  }
}
