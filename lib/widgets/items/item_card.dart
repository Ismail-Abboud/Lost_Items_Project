import 'package:flutter/material.dart';
import 'package:project1/pages/profile.dart';
import 'package:project1/widgets/items/userName_tag.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/thing.dart';
import './status_tag.dart';
import './location_tag.dart';
import 'title.dart';
import 'userName_tag.dart';
import '../../scoped_model/main.dart';

class ThingCard extends StatelessWidget {
  final Thing thing;
  final int thingIndex;

  ThingCard(this.thing, this.thingIndex);

  Widget _buildTitleStatusRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(thing.title),
          TitleDefault(thing.title),
          SizedBox(
            width: 8.0,
          ),
          StatusTag(thing.status),
          // Text(thing.description),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/thing/' + thingIndex.toString()),
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.displayedThings[thingIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectThing(thingIndex);
                model.toggleThingFavoriteStatus();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white10),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext) {
                  return ProfilePage(thing.userName);
                }));
              },
              child: UserNameTag(thing.userName),
            ),
          ),
          Image.asset(thing.image),
          _buildTitleStatusRow(),
          SizedBox(
            height: 10.0,
          ),
          LocationTag(thing.location),
          // Text(thing.userEmail),
          // Text(thing.description),
          _buildActionButtons(context),
          // Spacer(),
        ],
      ),
    );
  }
}
