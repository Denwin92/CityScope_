import 'package:city_scope/models/globals.dart';
import 'package:city_scope/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/feed.dart';
import 'feed_screen.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {


        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
          return LoginPage();
        }),(Route<dynamic> route) => false,);

      } else {
        FirebaseFirestore.instance
            .collection('User').doc(user.uid).get().then((value){
              Globals.cityScopeUser = CityScopeUser.fromJson(value.data()!);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
            return FeedScreen();
          }),(Route<dynamic> route) => false,);
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 150.0,
              child: Image.asset('assets/images/cs_logo1.png'),
            ),
          ],
        ),
      ),
    );
  }
}