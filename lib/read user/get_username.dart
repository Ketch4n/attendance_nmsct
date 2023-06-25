import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetScreen extends StatelessWidget {
  final String documentID;

  // ignore: use_key_in_widget_constructors
  const GetScreen({required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('Name : ${data['name']} ' '${data['email']}');
          }
          return const Text('Loading...');
        }));
  }
}
