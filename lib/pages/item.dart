import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/messages.dart';
import 'package:project1/pages/confirm.dart';
import 'package:project1/widgets/items/title.dart';
import 'package:scoped_model/scoped_model.dart';
// import '../widgets/ui_elements/title_default.dart';
import '../models/thing.dart';
import '../scoped_model/main.dart';
import '../widgets/items/title.dart';
import '../main.dart';

class ThingPage extends StatelessWidget {
  final int thingIndex;

  ThingPage(this.thingIndex);

  Widget _buildAddressStatusRow(String status, String location) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            SizedBox(
              width: 10.0,
            ),
            TitleDefault(location),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          status,
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  Widget _buildInformationRow(String info, String thingInfo) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              info + '\n',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              thingInfo,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Oswald', fontSize: 15.0),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Thing thing = model.displayedThings[thingIndex];
        return Scaffold(
          appBar: AppBar(
            title: Text(thing.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(thing.image),
              Container(
                padding: EdgeInsets.all(10.0),
                //child: TitleDefault(thing.title),
              ),
              _buildAddressStatusRow(thing.status, thing.location),
              Divider(),
              _buildInformationRow(
                  isArabic ? 'نوع الغرض' : 'Item Type:  ', thing.title),
              Divider(),
              _buildInformationRow(
                  isArabic ? 'التفاصيل' : 'Description:  ', thing.description),
              Divider(),
              thing.date.isNotEmpty
                  ? {
                      _buildInformationRow(
                          isArabic ? 'في تاريخ' : 'At Date:  ', thing.date),
                    }
                  : Container(),
              thing.time.isEmpty
                  ? Container()
                  : _buildInformationRow(
                      isArabic ? 'في الساعة' : 'In Time:  ', thing.time),
              Divider(),
              _buildInformationRow(
                  isArabic
                      ? 'للتواصل عبر البريدالإلكتروني'
                      : 'E_mail to contact:  ',
                  thing.userEmail),
              Divider(),
              _buildInformationRow(
                  isArabic ? 'للتواصل عبر الهاتف' : 'Number to call: ',
                  thing.number),
              Divider(),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MessagesPage(thingIndex);
                  }));
                },
                child: Text(isArabic ? "تأكيد" : "confirm"),
              )
            ],
          ),
        );
      },
    ));
  }
}
