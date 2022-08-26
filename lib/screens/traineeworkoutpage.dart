import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/components/customloading.dart';
import 'package:fitness_app_instructor/screens/Ins_Navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class traineeworkout extends StatefulWidget {
  String? trainee_mail;


  traineeworkout({this.trainee_mail});

  @override
  _traineeworkoutState createState() => _traineeworkoutState();
}

class _traineeworkoutState extends State<traineeworkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('Workout History')),
        drawer: Ins_navdrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.trainee_mail!,style: TextStyleMediumBlack,),
                  SizedBox(height: 10,),
                  Text('Workout Data',style: TextStyleHeadingBlack,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("userexer")
                      .doc(widget.trainee_mail)
                      .collection("workouts")
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      //TODO adding a loading bar
                      return customloading();
                    }

                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document["title"],style: TextStyleFormBlackBold,),
                                SizedBox(
                                  height: 5,
                                ),
                                //STEPS
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Exercise time: " + document['exrtime'],
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
                                      document['date'],
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
            ),
          ],
        ),
    );
  }
}
