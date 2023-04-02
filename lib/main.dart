import 'package:author_registration_app/view/screens/Home_Page.dart';
import 'package:author_registration_app/view/screens/Login.dart';
import 'package:author_registration_app/view/screens/Sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: 'signPage',
        routes: {
          '/': (context) => HomePage(),
          'signPage': (context) => Sign_Up(),
          'Login': (context) => LoginPage(),
        }),
  );
}
