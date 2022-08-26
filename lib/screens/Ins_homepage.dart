import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/screens/Ins_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Ins_Navdrawer.dart';
import 'Ins_profile.dart';
import 'Ins_trainee.dart';

class Ins_homepage extends StatefulWidget {
  @override
  _Ins_homepageState createState() => _Ins_homepageState();
}

class _Ins_homepageState extends State<Ins_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instructor Home"),
        actions: [
          IconButton(icon: Icon(Icons.login_outlined), onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Ins_LoginPage()));
          })
        ],
      ),
      drawer: Ins_navdrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/trainer_head.jpg"),
              fit: BoxFit.cover,
            )),
            child: Text(
              "Welcome, Trainer",
              style: TextStyleHeadingBold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: trainertabs(
                              label: "Profile",
                              imgpath: "images/profile_trainer.jpg",
                              onpress: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Ins_profilepage()));
                              }),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: trainertabs(
                              label: "Trainees",
                              imgpath: "images/mytrainees.jpg",
                              onpress: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Ins_traineePage()));
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: trainertabs(
                            label: "Reviews",
                            imgpath: "images/review_trainer.jpg",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector trainertabs(
      {required String imgpath, required String label, Function? onpress}) {
    return GestureDetector(
      onTap: onpress as void Function()?,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomLeft,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: AssetImage(imgpath),
              fit: BoxFit.cover,
            )),
        child: Text(
          label,
          style: TextStyleHeadingBold,
        ),
      ),
    );
  }
}
