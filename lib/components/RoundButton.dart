import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButton extends StatelessWidget {
  String? textval;
  double? height;
  double? width;
  Function? onpress;


  RoundButton({this.textval, this.height, this.width,this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: mainaccent,
        elevation: 5.0,
        child: MaterialButton(
          splashColor: Colors.transparent,
          onPressed: onpress as void Function()?,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: Colors.white, width: 1)
          ),
          child: Text(textval!, style: TextStyleForm),
        ),
      ),
    );
  }
}
