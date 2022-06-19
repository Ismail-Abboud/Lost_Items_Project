import 'package:flutter/material.dart';
import 'package:project1/pages/add_page.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
// import '../models/thing.dart';

class ThingList extends StatelessWidget {
  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectThing(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AddPage("");
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allThings[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectThing(index);
                  model.deleteThing();
                }
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.allThings[index].image),
                    ),
                    title: Text(model.allThings[index].title),
                    subtitle: Text('${model.allThings[index].status}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allThings.length,
        );
      },
    );
  }
}
