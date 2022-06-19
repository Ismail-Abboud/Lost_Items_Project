// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/confirm.dart';
import 'package:project1/pages/messages.dart';
import 'package:project1/pages/myConfirms_list.dart';
import '../widgets/items/userName_tag.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';

class ConfirmBack extends StatelessWidget {
  final Thing thing;
  ConfirmBack(this.thing);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(isArabic ? 'تأكيد الغرض' : 'confirm item'),
          ),
        ),
        body: Form(
            // padding: EdgeInsets.all(5.0),
            key: _key,
            child: ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
              return ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  Card(
                    child: Column(
                      children: <Widget>[
                        UserNameTag(thing.userName),
                        Image.asset(thing.image),
                        Text(thing.description),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(thing.confirmMoney),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            thing.confirmDescription,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    buttonMinWidth: 120.0,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          thing.responsed = 1;
                        },
                        child: Text(
                            isArabic ? "نعم إنه الغرض" : "yes, that is it"),
                        color: Colors.blue[50],
                      ),
                      RaisedButton(
                        color: Colors.blue[50],
                        onPressed: () {
                          thing.responsed = 0;

                          _key.currentState.save();
                        },
                        child: Text(isArabic
                            ? 'لا ليس هذا الغرض'
                            : "no, that's not it"),
                      ),
                    ],
                  ),
                ],
              );
            })));
  }
}
