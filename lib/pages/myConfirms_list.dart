import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/confirm.dart';
import 'package:project1/pages/confirm_back.dart';
import 'package:project1/pages/myConfirm_request.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';

class myConfirmsList extends StatelessWidget {
  final int index;

  myConfirmsList(this.index);
  Widget _buildConfirmRequestButton(
      BuildContext context, int index, MainModel model, Thing thing) {
    return IconButton(
      icon: Icon(Icons.confirmation_num_outlined),
      onPressed: () {
        model.selectThing(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyConfirmRequest(thing);
            },
          ),
        ).then((_) => model.selectThing(null));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(isArabic
                ? 'طلباتي لتأكيد الأغراض'
                : 'My Request confirm Items'),
          ),
        ),
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return model.displayConfirmedItems.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(isArabic
                            ? "لم ترسل طلب تأكيد بعد"
                            : "you did not send confirm requests yet"),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    model.displayConfirmedItems[index].image),
                              ),
                              title: Text(
                                  model.displayConfirmedItems[index].title),
                              subtitle: Text(
                                  '${model.displayConfirmedItems[index].status}'),
                              trailing: _buildConfirmRequestButton(
                                  context,
                                  index,
                                  model,
                                  model.displayConfirmedItems[index]),
                            ),
                            Divider()
                          ],
                        ),
                      );
              },
              itemCount: model.displayConfirmedItems.length,
            );
          },
        ));
  }
}
