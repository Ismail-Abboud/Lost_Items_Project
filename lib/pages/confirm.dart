import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/confirmItems_list.dart';
import 'package:project1/pages/myConfirms_list.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/image.dart';
import '../models/thing.dart';
import '../scoped_model/main.dart';

class ConfirmItem extends StatefulWidget {
  final int thingIndex;

  ConfirmItem(this.thingIndex);
  @override
  State<StatefulWidget> createState() {
    return ConfirmItemState();
  }
}

class ConfirmItemState extends State<ConfirmItem> {
  bool _response = false;

  Map<String, dynamic> _confirmData = {
    "image": "",
    'money': "",
    'description': "",
  };

  final GlobalKey<FormState> _confirmkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(60.0),
        child: Form(
          key: _confirmkey,
          child: ListView(
            children: [
              ImageInput(),
              TextFormField(
                decoration: InputDecoration(
                    labelText: isArabic
                        ? 'إذا كان نقوداً,كم المبلغ؟'
                        : 'if it is money , how much?'),
                onSaved: (String value) {
                  _confirmData['money'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: isArabic
                        ? 'بعض التفاصيل التي ترغب بإضافتها؟'
                        : 'some details you want to add?'),
                onSaved: (String value) {
                  _confirmData['description'] = value;
                  Text(value);
                },
                maxLines: 2,
              ),
              // Text(_confirmData['desc']),
              SizedBox(
                height: 20.0,
              ),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                // model.selectThing(widget.thingIndex);
                return model.allThings[widget.thingIndex].confirmed
                    ? Text(
                        isArabic
                            ? _confirmData['description'] +
                                _confirmData['money'] +
                                ' تم الإرسال بنجاح'
                            : _confirmData['description'] +
                                _confirmData['money'] +
                                ' Sent Successfully!',
                        textAlign: TextAlign.center,
                      )
                    : FlatButton(
                        onPressed: () {
                          model.selectThing(widget.thingIndex);

                          model.toggleThingConfirmStatus();
                          _confirmkey.currentState.save();
                          ConfirmItemList(widget.thingIndex);
                          model.selectedthing.confirmDescription =
                              _confirmData['description'];
                          model.selectedthing.confirmMoney =
                              _confirmData['money'];
                          model.selectedthing.confirmImage =
                              _confirmData['image'];
                          model.selectThing(null);
                        },
                        child: Text(isArabic ? 'إرسال' : 'send'),
                      );
              }),
            ],
          ),
        ));
  }
}
