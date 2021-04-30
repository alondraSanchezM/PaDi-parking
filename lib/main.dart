import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:padi_parking/src/welcome.dart';
import 'src/firstTime.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaDi',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color _color = Color.fromARGB(255, 12, 36, 49);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => FirstTime()),
              (Route<dynamic> route) => false);
        } else {
          print('User is signed in!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomePage()),
              (Route<dynamic> route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Center(
        child: Image.asset("assets/PaDi-logo.png"),
      ),
    );
  }
}
