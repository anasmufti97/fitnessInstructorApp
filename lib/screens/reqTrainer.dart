import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/RectButton.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/components/customloading.dart';
import 'package:fitness_app_instructor/screens/Ins_Navdrawer.dart';
import 'package:fitness_app_instructor/screens/trainee_profile.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class reqtrainer extends StatefulWidget {
  @override
  _reqtrainerState createState() => _reqtrainerState();
}

class _reqtrainerState extends State<reqtrainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainers Requests'),
      ),
      drawer: Ins_navdrawer(),
      body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('instructor')
                .doc(FirebaseAuth.instance.currentUser!.email.toString())
                .collection('Trainer')
                .where('status', isEqualTo: "pending")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    );
  }
}

class ProfileCard extends StatefulWidget {
  String? email;

  ProfileCard({this.email});

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String insemail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
        padding: EdgeInsets.all(10),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.email!,
                      style: TextStyleFormBlack,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RectButton(
                          textval: 'Accept',
                          height: 40,
                          onpress: () {
                            addtrainer(widget.email, context);
                          },
                        ),
                        RectButton(
                          textval: 'Decline',
                          height: 40,
                          onpress: () {
                            removetrainer(widget.email, context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addtrainer(String? traineremail, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("instructor")
        .doc(insemail)
        .collection('Trainer')
        .doc(traineremail)
        .update({
          'status': 'approved',
        })
        .then((value) => print("Request accepted"))
        .catchError((error) => print("Failed to accept Request: $error"));

    await FirebaseFirestore.instance
        .collection('users')
        .doc(traineremail)
        .collection("myinstructor")
        .doc(insemail)
        .set({
      'id': insemail,
    }).then((value) {
      print("added ins in user");
      Toast.show("Request Accepted", gravity: Toast.bottom, duration: 4);
    }).catchError((error) => print("Failed to add ins in user: $error"));
  }

  Future<void> removetrainer(String? traineremail, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("instructor")
        .doc(insemail)
        .collection('Trainer')
        .doc(traineremail)
        .delete()
        .then((value) {
      print("removed request");
      Toast.show("Request Declined", gravity: Toast.bottom, duration: 4);
    }).catchError((error) => print("Failed to remove request: $error"));
  }
}
