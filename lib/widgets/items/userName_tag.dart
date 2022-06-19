import 'package:flutter/material.dart';

class UserNameTag extends StatelessWidget {
  final String name;

  UserNameTag(this.name);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: AssetImage('assets/question.png'),
      ),
      Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.5),
        child: Text(
          name,
          style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
