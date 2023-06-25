// ignore_for_file: prefer_const_constructors

import 'package:attendance_nmsct/auth/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../loading.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Try Again'),
              );
            } else if (snapshot.hasData) {
              return const LoadingScreen();
            }
            // else if (snapshot.hasData && snapshot.hasError) {
            //   return const CreateScreen();
            // }
            else {
              return const LoginScreen();
            }
          }),
    );
  }
}
