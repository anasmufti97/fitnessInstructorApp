import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/screens/Ins_homepage.dart';
import 'package:fitness_app_instructor/screens/Ins_login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  late FirebaseAuth auth;



  void checklogin() async {




    auth = FirebaseAuth.instance;
    User loggedInuser;
    final user = await auth.currentUser;



    if (user != null) {
      loggedInuser = user;
      //IF TRUE REDIRECT TO MAIN PAGE
      if(loggedInuser.email != null)
      {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Ins_homepage()),
        );

//        });
      }
    }
    //IF NOT TRUE REDIRECT TO WELCOME SCREEN
    else
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Ins_LoginPage()),
      );
    }

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () =>checklogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/minerva.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
