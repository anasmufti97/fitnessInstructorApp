import 'package:flutter/material.dart';
import 'constants.dart';

class FormTextFieldDark extends StatelessWidget {
  bool? obscuretext;
  var inputtype;
  String? labeltext;
  Function? onChanged;



  FormTextFieldDark({this.obscuretext, this.inputtype, this.labeltext, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged as void Function(String)?,
      obscureText: obscuretext!,
      keyboardType: inputtype,
      style: TextStyleFormBlack,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle:
        TextStyle(fontSize: 18, color: Colors.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainaccent),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}