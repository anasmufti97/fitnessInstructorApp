import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_instructor/components/DarkTextField.dart';
import 'package:fitness_app_instructor/components/RoundButton.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/components/customloading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'Ins_Navdrawer.dart';

class Ins_profilepage extends StatefulWidget {
  @override
  _Ins_profilepageState createState() => _Ins_profilepageState();
}

class _Ins_profilepageState extends State<Ins_profilepage> {
  String currentuser = FirebaseAuth.instance.currentUser!.email.toString();
  File? _imagefile;
  String? imagestring;
  Uint8List? imagebytes;
  String? name;
  String? age;

  Future getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagefile = File(image!.path);
      List<int> imageByte = File(image.path).readAsBytesSync();
      imagestring = base64Encode(imageByte);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Ins_navdrawer(),
      appBar: AppBar(title: Text("Instructor Profile")),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('instructor')
            .doc(currentuser)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['image'].toString() != "N/A") {
              imagebytes = base64.decode(data['image'].toString());
            }
            return Column(
              children: [
                //FIRST ONE
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20, top: 10),
                    decoration: BoxDecoration(
                        color: mainaccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(400, 60),
                            bottomLeft: Radius.elliptical(400, 60))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
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
                                      image: _imagefile == null
                                          ? (imagebytes == null?AssetImage("images/profile_avatar.png"):MemoryImage(imagebytes!)) as ImageProvider<Object>
                                          : FileImage(_imagefile!),
                                      // _imagefile==null?AssetImage(
                                      //     "images/profile_avatar.png"):FileImage(_imagefile),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['email'],
                          style: TextStyleMedium,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DarkTextField(
                            inputtype: TextInputType.text,
                            inputval: data['name'].toString(),
                            onChanged: (String getName) {
                              name = getName;
                            },
                          ),
                          DarkTextField(
                            inputtype: TextInputType.number,
                            inputval: data['age'].toString(),
                            onChanged: (String getAge) {
                              age = getAge;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          RoundButton(
                            textval: "Update",
                            height: 40,
                            width: 100,
                            onpress: () {
                              updateInsProfileData(data['name'],data['age'],data['image']);

                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }

          return customloading();
        },
      ),
    );
  }

  Future<void> updateInsProfileData(String? dataname,String? dataage, String? dataimage) async {
    await FirebaseFirestore.instance
        .collection('instructor')
        .doc(currentuser)
        .update({
          'name': name==null?dataname:name,
          'age': age==null?dataage:age,
          'image': imagestring==null?dataimage:imagestring,
        })
        .then((value) => print('Data Added'))
        .catchError((e) => print('Failed to add data'));
  }
}
