import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({this.heightFactor = 1, this.widthFactor = 1, super.key});

  final int heightFactor;
  final int widthFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0 * heightFactor,
      width: 10.0 * widthFactor,
    );
  }
}
