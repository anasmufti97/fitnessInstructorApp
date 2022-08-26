import 'package:flutter/material.dart';
import 'constants.dart';

class FormTextField extends StatelessWidget {
  bool? obscuretext;
  var inputtype;
  String? labeltext;
  Function? onChanged;



  FormTextField({this.obscuretext, this.inputtype, this.labeltext, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged as void Function(String)?,
      obscureText: obscuretext!,
      keyboardType: inputtype,
      style: TextStyleForm,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle:
        TextStyle(fontSize: 18, color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}