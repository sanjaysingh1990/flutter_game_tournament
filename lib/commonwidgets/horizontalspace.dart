import 'package:flutter/cupertino.dart';

class HorizontalSpace extends StatelessWidget {
  final double value;

  HorizontalSpace({@required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      width: value,
    );
  }
}
