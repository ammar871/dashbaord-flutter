import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomButton2 extends StatelessWidget {
  final void Function() onPress;
  final String icon;
  final Color color;
  double width ,height;

  CustomButton2(
      { this.onPress,  this.icon,  this.color,this.width=46
      ,this.height=46});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Container(),
        ),
      ),
    );
  }
}