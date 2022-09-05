import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class OrSeperator extends StatelessWidget {
  const OrSeperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 10,
          width: 150,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 2))),
        ),
        Text(
          'OR',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Container(
          height: 10,
          width: 150,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 2))),
        ),
      ],
    );
  }
}
