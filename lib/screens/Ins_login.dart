import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/FormTextField.dart';
import 'package:fitness_app_instructor/components/RoundButton.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Ins_SignUp.dart';
import 'Ins_homepage.dart';

class Ins_LoginPage extends StatefulWidget {
  @override
  Ins_LoginPage_State createState() => Ins_LoginPage_State();
}

class Ins_LoginPage_State extends State<Ins_LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? email, password;
  bool loading = false;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Instructor Login",
                        style: TextStyleHeading,
                      ),
                      Text(
                        "____",
                        style: TextStyleHeading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormTextField(
                        obscuretext: false,
                        inputtype: TextInputType.emailAddress,
                        labeltext: "Email",
                        onChanged: (String getemail) {
                          email = getemail;
                          print(email);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                        obscuretext: true,
                        inputtype: TextInputType.text,
                        labeltext: "Password",
                        onChanged: (String getpass) {
                          password = getpass;
                          print(getpass);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                      FractionalTranslation(
                        translation: Offset(0, .4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundButton(
                              textval: "Login",
                              height: 40,
                              width: 120,
                              onpress: () async {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  final user = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: email!,
                                    password: password!,
                                  );
                                  if (user != null) {
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
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'No user found for that email.'));
                                    _scaffoldKey.currentState!
                                        .showSnackBar(snackBar);
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'Wrong password provided for that user.'));
                                    _scaffoldKey.currentState!
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF252BA8), Color(0xFF2F2A6E)]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(400, 60),
                          bottomLeft: Radius.elliptical(400, 60))),
                ),

                //other half
                Container(
                  padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "or login with",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x93000000),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              splashColor: Colors.transparent,
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(FontAwesomeIcons.facebook),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x93000000),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              splashColor: Colors.transparent,
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(FontAwesomeIcons.google),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ins_SignUpPage()),
                              );
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                        textval: "I'm a User",
                        height: 50,
                        width: 150,
                        onpress: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ins_LoginPage()),
                          );
                        },
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
}
