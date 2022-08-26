import 'package:flutter/material.dart';

import 'constants.dart';

class PlanCards extends StatelessWidget {
  String? imagepath;
  String? Cardtext;
  Function? ontap;
  Color? color1,color2,color3;

  PlanCards({this.imagepath, this.Cardtext, this.ontap,this.color1,this.color2,this.color3});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap as void Function()?,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagepath!), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Cardtext!,
                style: TextStyleHeadingBold,
              ),
              Row(
                children: [
                  Icon(Icons.offline_bolt,color: color1,),
                  Icon(Icons.offline_bolt,color: color2,),
                  Icon(Icons.offline_bolt,color: color3,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}