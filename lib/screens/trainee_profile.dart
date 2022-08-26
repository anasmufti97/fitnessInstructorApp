import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/screens/chatscreen.dart';
import 'package:fitness_app_instructor/screens/contentpage.dart';
import 'package:fitness_app_instructor/screens/runninghistory.dart';
import 'package:fitness_app_instructor/screens/traineeworkoutpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Ins_Navdrawer.dart';

class trainee_profile extends StatefulWidget {
  String? email;

  trainee_profile({this.email});

  @override
  _trainee_profileState createState() => _trainee_profileState();
}

class _trainee_profileState extends State<trainee_profile> {
  String? workout = '0', kcal = '0', minute = '0';
  String? name = '';
  String? height = '0';
  String? weight = '0';

  Future<void> getTrainerExerData() async {
    await FirebaseFirestore.instance
        .collection('userexer')
        .doc(widget.email)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (snapshot.data() != null) {
          setState(() {
            workout = data!['workout'];
            kcal = data['kcal'];
            minute = data['minute'];
          });
        }
      });
    });
  }

  Future<void> getUderData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (snapshot.data() != null) {
          setState(() {
            name = data!['name'];
            weight = data['weight'];
            height = data['height'];
          });
        }
      });
    });
  }

  @override
  void initState() {
    getTrainerExerData();
    getUderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainee Profile"),
        elevation: 0.0,
      ),
      drawer: Ins_navdrawer(),
      body: Container(
        child: Column(
          children: [
            //header
            Container(
              height: 210,
              padding: EdgeInsets.only(bottom: 20, top: 10),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: Container(
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              workout!,
                              style: TextStyleForm,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "WORKOUT",
                              style: TextStyleForm,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              kcal!,
                              style: TextStyleForm,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "KCAL",
                              style: TextStyleForm,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              minute!,
                              style: TextStyleForm,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "MINUTE",
                              style: TextStyleForm,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Material(
                                elevation: 5,
                                color: Colors.blue,
                                child: MaterialButton(
                                  elevation: 5,
                                  splashColor: Colors.amber,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => chatscreen(
                                                  recvremail: widget.email,
                                                )));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.chat),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ClipOval(
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Material(
                                elevation: 5,
                                color: Colors.green,
                                child: MaterialButton(
                                  elevation: 5,
                                  splashColor: Colors.red,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Name: ",
                            style: TextStyleFormBlackBold,
                          ),
                          Text(
                            name!,
                            style: TextStyleFormBlack,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Weight: ",
                            style: TextStyleFormBlackBold,
                          ),
                          Text(
                            weight!,
                            style: TextStyleFormBlack,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "height: ",
                            style: TextStyleFormBlackBold,
                          ),
                          Text(
                            height!,
                            style: TextStyleFormBlack,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Learning',
                        style: TextStyleHeadingBlack,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      TrainerProfileCards(
                        icondata: FontAwesomeIcons.fileAlt,
                        title: 'Content',
                        iconcolor: Colors.white70,
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => contentpage()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'History',
                        style: TextStyleHeadingBlack,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      TrainerProfileCards(
                        icondata: FontAwesomeIcons.fireAlt,
                        title: 'Workout',
                        iconcolor: Colors.orange,
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => traineeworkout(
                                        trainee_mail: widget.email,
                                      )));
                        },
                      ),
                      TrainerProfileCards(
                        icondata: FontAwesomeIcons.running,
                        title: 'Running',
                        iconcolor: Colors.red,
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => runninghistory(
                                        traineremail: widget.email,
                                      )));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrainerProfileCards extends StatelessWidget {
  String? title;
  IconData? icondata;
  Function? onpress;
  Color? iconcolor;

  TrainerProfileCards(
      {this.title, this.icondata, this.iconcolor, this.onpress});

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
                color: iconcolor,
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
