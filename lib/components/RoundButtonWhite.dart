import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButtonWhite extends StatelessWidget {
  String? textval;
  double? height;
  double? width;
  Function? onpress;


  RoundButtonWhite({this.textval, this.height, this.width,this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        onPressed: onpress as void Function()?,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(textval!, style: TextStyleFormBlack),
      ),
    );
  }
}
