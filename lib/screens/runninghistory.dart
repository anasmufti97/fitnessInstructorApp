import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/screens/Ins_Navdrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class runninghistory extends StatefulWidget {
  String? traineremail;


  runninghistory({this.traineremail});

  @override
  _runninghistoryState createState() => _runninghistoryState();
}

class _runninghistoryState extends State<runninghistory> {
  FirebaseAuth? auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Ins_navdrawer(),
      appBar: AppBar(
        title: Text("Running History"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("userexer")
              .doc(widget.traineremail)
              .collection("running")
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              //TODO adding a loading bar
              return Center(
                child: Text(
                  "Loading Data Please Wait",
                  style: TextStyleHeadingBlack,
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //STEPS
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.walking,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Steps: " + document['steps'],
                              style: TextStyleFormBlack,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //DISTANCE
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Distance: " + document['distance'],
                              style: TextStyleFormBlack,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //KCAL
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.fire,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "KCAL: " + document['kcal'],
                              style: TextStyleFormBlack,
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              document['time'],
                              style: TextStyleFormBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
