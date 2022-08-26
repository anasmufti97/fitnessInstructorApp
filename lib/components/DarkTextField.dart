import 'package:flutter/material.dart';
import 'constants.dart';

class DarkTextField extends StatelessWidget {
  var inputtype;
  Function? onChanged;
  String? inputval;

  DarkTextField({this.inputtype, this.onChanged, this.inputval});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: onChanged as void Function(String)?,
      keyboardType: inputtype,
      style: TextStyleFormBlack,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.edit),
        hintText: inputval,
        hintStyle: TextStyle(fontSize: 18, color: mainaccent),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainaccent),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
      ),
    );
  }
}
