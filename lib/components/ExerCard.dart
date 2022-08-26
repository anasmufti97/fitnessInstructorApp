import 'package:fitness_app_instructor/components/constants.dart';
import 'package:flutter/material.dart';

class ExerCard extends StatelessWidget {

  String? title;
  String? req;
  String? gifpath;
  Function? ontap;

  ExerCard({this.title, this.req, this.gifpath,this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap as void Function()?,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                    color: Colors.white,
                    child: Image.asset(gifpath!)),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title!,
                        style: TextStyleFormBlackBold,
                      ),
                      Text(
                        req!,
                        style: TextStyleFormBlack,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
