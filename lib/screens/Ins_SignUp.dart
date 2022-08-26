import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/FormTextField.dart';
import 'package:fitness_app_instructor/components/RoundButton.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'Ins_homepage.dart';
import 'Ins_login.dart';

class Ins_SignUpPage extends StatefulWidget {
  @override
  _Ins_SignUpPageState createState() => _Ins_SignUpPageState();
}

class _Ins_SignUpPageState extends State<Ins_SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? email, pass, name, age, contact;
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  bool loading = false;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF252BA8), Color(0xFF2F2A6E)]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(400, 60),
                          bottomLeft: Radius.elliptical(400, 60))),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Instructor Sign Up",
                          style: TextStyleHeading,
                        ),
                        Text(
                          "____",
                          style: TextStyleHeading,
                        ),
                        FormTextField(
                          obscuretext: false,
                          inputtype: TextInputType.text,
                          labeltext: "Name",
                          onChanged: (String getName) {
                            name = getName;
                          },
                        ),
                        FormTextField(
                          obscuretext: false,
                          inputtype: TextInputType.number,
                          labeltext: "Age",
                          onChanged: (String getAge) {
                            age = getAge;
                          },
                        ),
                        FormTextField(
                          obscuretext: false,
                          inputtype: TextInputType.emailAddress,
                          labeltext: "Email",
                          onChanged: (String getEmail) {
                            email = getEmail;
                          },
                        ),
                        FormTextField(
                          obscuretext: true,
                          inputtype: TextInputType.text,
                          labeltext: "Password",
                          onChanged: (String getPass) {
                            pass = getPass;
                          },
                        ),
                        FormTextField(
                          obscuretext: false,
                          inputtype: TextInputType.number,
                          labeltext: "Contact",
                          onChanged: (String getContact) {
                            contact = getContact;
                          },
                        ),
                        FractionalTranslation(
                          translation: Offset(0, .5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RoundButton(
                                textval: "SignUp",
                                height: 40,
                                width: 120,
                                onpress: () async {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    final newuser = await auth
                                        .createUserWithEmailAndPassword(
                                      email: email!,
                                      password: pass!,
                                    );
                                    if (newuser != null) {
                                      addInsData();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Ins_homepage()));
                                    }

                                    setState(() {
                                      loading = false;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      loading = false;
                                    });

                                    if (e.code == 'weak-password') {
                                      final snackBar = SnackBar(
                                          content: Text('Weak Password'));
                                      _scaffoldKey.currentState!
                                          .showSnackBar(snackBar);
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'The account already exists for that email.'));
                                      _scaffoldKey.currentState!
                                          .showSnackBar(snackBar);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      new GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ins_LoginPage()),
                          );
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addInsData() async {
    final users = await firestore
        .collection('instructor')
        .doc(email)
        .set({
          'id': email,
          'email': email,
          'name': name,
          'age': age,
          'contact': contact,
          'type': 'instructor',
          'image': 'N/A',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return users;
  }
}
