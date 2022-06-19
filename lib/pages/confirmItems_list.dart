import 'package:flutter/material.dart';
import 'package:project1/pages/confirm_back.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';

class ConfirmItemList extends StatelessWidget {
  final int index;
  ConfirmItemList(this.index);

  Widget _buildConfirmButton(
      BuildContext context, int index, MainModel model, Thing thing) {
    return IconButton(
      icon: Icon(Icons.circle_notifications),
      onPressed: () {
        // model.selectThing(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ConfirmBack(thing);
            },
          ),
        ).then((_) => model.selectThing(null));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return
                // children: [
                Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(model.displayConfirmedItems[index].image),
                    ),
                    title: Text(model.displayConfirmedItems[index].title + ' '),
                    subtitle: Text(
                        model.displayConfirmedItems[index].confirmMoney +
                            model.displayConfirmedItems[index].description),
                    trailing: _buildConfirmButton(context, index, model,
                        model.displayConfirmedItems[index]),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.displayConfirmedItems.length);
    });
  }
}
