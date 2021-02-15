import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bluestack/utils/AppColors.dart';
import 'package:flutter_app_bluestack/utils/AssetStrings.dart';

class ActionButton extends StatelessWidget {
  VoidCallback callback;
  String label;
  double margin;
  Color buttonColor;

  ActionButton(
      {this.callback,
      this.label,
      this.margin,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.0,
      margin: new EdgeInsets.only(left: margin, right: margin),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: Material(
        borderRadius: new BorderRadius.circular(8.0),
        child: Ink(
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(8.0), color: buttonColor),
          child: InkWell(
            borderRadius: new BorderRadius.circular(8.0),
            splashColor: buttonColor,
            onTap: () {
              callback();
            },
            child: new Container(
              alignment: Alignment.center,
              child: new Text(
                label,
                style: new TextStyle(
                  fontFamily: AssetStrings.circulerMedium,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
