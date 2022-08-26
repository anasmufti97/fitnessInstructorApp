import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/components/customloading.dart';
import 'package:fitness_app_instructor/screens/reqTrainer.dart';
import 'package:fitness_app_instructor/screens/trainee_profile.dart';
import 'package:fitness_app_instructor/screens/videocallpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Ins_Navdrawer.dart';

class Ins_traineePage extends StatefulWidget {
  @override
  _Ins_traineePageState createState() => _Ins_traineePageState();
}

class _Ins_traineePageState extends State<Ins_traineePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainees"),
        elevation: 0.0,
        actions: [
          IconButton(
            splashColor: Colors.white.withOpacity(0.2),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => reqtrainer()));
            },
            icon: Icon(FontAwesomeIcons.userPlus),
          )
        ],
      ),
      drawer: Ins_navdrawer(),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 7.0,
                  ),
                ],
                color: mainaccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(400, 60),
                    bottomLeft: Radius.elliptical(400, 60))),
            child: Center(
                child: Text(
              "Your Trainees",
              style: TextStyleHeading,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InsTrainerProfileCards(
              title: "Live Video Call",
              icondata: Icons.video_call,
              onpress: () {
                // Navigator.push(c
                //ontext, MaterialPageRoute(builder: (context)=>videocallpage()));
              },
            ),
          ),
          Expanded(
            child: Container(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('instructor')
                  .doc(FirebaseAuth.instance.currentUser!.email.toString())
                  .collection('Trainer')
                  .where('status', isEqualTo: "approved")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return ProfileCard(
                        email: document['id'],
                      );
                    }).toList(),
                  );
                }
                return customloading();
              },
            )),
          )
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  String? email;

  ProfileCard({this.email});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => trainee_profile(
                      email: email,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 120,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/profile_avatar.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    email!,
                    style: TextStyleFormBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InsTrainerProfileCards extends StatelessWidget {
  String? title;
  IconData? icondata;
  Function? onpress;

  InsTrainerProfileCards({this.title, this.icondata, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 80,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.indigo,
        elevation: 5.0,
        child: MaterialButton(
          elevation: 5.0,
          onPressed: onpress as void Function()?,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                icondata,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title!,
                style: TextStyleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
