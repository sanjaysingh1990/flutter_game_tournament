import 'package:flutter/cupertino.dart';

class VerticalSpace extends StatelessWidget {
  final double value;

  VerticalSpace({@required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      height: value,
    );
  }
}
