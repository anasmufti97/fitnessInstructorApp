import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app_instructor/components/constants.dart';
import 'package:fitness_app_instructor/main.dart';
import 'package:fitness_app_instructor/screens/Ins_Navdrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class contentpage extends StatefulWidget {
  @override
  _contentpageState createState() => _contentpageState();
}

class _contentpageState extends State<contentpage> {
  String useremail = FirebaseAuth.instance.currentUser!.email.toString();

  Future<File> createFileOfPdfUrl(String geturl, String? getfilename) async {
    final url = geturl;
    final filename = getfilename;
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      drawer: Ins_navdrawer(),
      appBar: AppBar(
        title: Text("Content"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getpdfandUpload();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: mainaccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("instructor")
              .doc(useremail)
              .collection('Content')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return ContentCards(
                    title: document['filename'],
                    onpress: () {
                      String pathPDF;
                      createFileOfPdfUrl(
                              document["url"].toString(), document['filename'])
                          .then((f) {
                        setState(() {
                          pathPDF = f.path;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFScreen(
                                      pathPDF, document['filename'])));
                        });
                      });
                    },
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> getpdfandUpload() async {
    FilePickerResult? fileresult =
        await (FilePicker.platform.pickFiles(type: FileType.custom));
    File fileforfirebase = File(fileresult!.files.first.path!);
    String filename = fileresult.files.first.name;
    savepdf(fileforfirebase, filename);
  }

  Future<void> savepdf(File asset, String filename) async {
    try {
      TaskSnapshot uploadTask = await FirebaseStorage.instance
          .ref()
          .child("$filename")
          .putFile(asset);
      String url = await uploadTask.ref.getDownloadURL();
      saveurlref(url, filename);
    } on Exception catch (e) {
      Toast.show(
        "Error",
        gravity: Toast.bottom,
        duration: 3,
      );
    }
  }

  Future<void> saveurlref(String url, String filename) async {
    await FirebaseFirestore.instance
        .collection("instructor")
        .doc(useremail)
        .collection('Content')
        .doc()
        .set({'url': url.toString(), 'filename': filename.toString()}).then(
            (value) {
      print("Saved Successfully");
      Toast.show(
        "Uploaded Successfully",
        gravity: Toast.bottom,
        duration: 3,
      );
    }).catchError((e) => print("Error Saving"));
  }
}

class ContentCards extends StatelessWidget {
  String? title;
  IconData? icondata;
  Function? onpress;
  Color? iconcolor;

  ContentCards({this.title, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 80,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
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
                FontAwesomeIcons.solidFilePdf,
                color: Colors.redAccent,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title!,
                style: TextStyleMediumBlack,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  String? name = "";

  PDFScreen(this.pathPDF, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: PDFView(filePath: pathPDF),
    );
  }
}
