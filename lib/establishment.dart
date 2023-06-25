import 'package:attendance_nmsct/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EstablishmentScreen extends StatefulWidget {
  const EstablishmentScreen({Key? key}) : super(key: key);

  @override
  State<EstablishmentScreen> createState() => _EstablishmentScreenState();
}

class _EstablishmentScreenState extends State<EstablishmentScreen> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueGrey, Colors.white])),
        child: Scaffold(
          appBar: AppBar(title: const Text('USERS')),
          backgroundColor: Colors.transparent,
          body: StreamBuilder<List<User2>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong ${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map(buildUser).toList(),
                );
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

  Stream<List<User2>> readUsers() => FirebaseFirestore.instance
      .collection('Users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User2.fromJson(doc.data())).toList());
}
