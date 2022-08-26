import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

class customloading extends StatefulWidget {
  @override
  _customloadingState createState() => _customloadingState();
}

class _customloadingState extends State<customloading> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: mainaccent,
        size: 50.0,
        controller: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1200)),
      ),
    );
  }
}
