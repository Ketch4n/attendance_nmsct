// ignore_for_file: depend_on_referenced_packages
import 'package:attendance_nmsct/auth/auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     
      options: const FirebaseOptions(
          apiKey: "AIzaSyA-dgZhmKBiW6Mq3rkQnvaa_mubfZkam8E",
          authDomain: "attendance-nmsct.firebaseapp.com",
          databaseURL: "https://attendance-nmsct-default-rtdb.firebaseio.com",
          projectId: "attendance-nmsct",
          storageBucket: "attendance-nmsct.appspot.com",
          messagingSenderId: "110169318047",
          appId: "1:110169318047:web:94ba5203cb3d6755e578aa",
          measurementId: "G-TP4FJ8VT47"));

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: KeyboardVisibilityProvider(
        child: const AuthScreen(),
      ),
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
