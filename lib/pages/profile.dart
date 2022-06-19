import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/home.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main.dart';
import '../widgets/profileDrawer.dart';
import '../widgets/items/items.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  ProfilePage(this.userName);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: buildProfileDrawer(context),
            appBar: AppBar(
              title: Text(isArabic ? ' $userName حساب' : '$userName profile'),
            ),
            body: Container(
              // child: ListView(
              //   children: [
              //     // ScopedModelDescendant(builder:
              //     //     (BuildContext context, Widget child, MainModel model) {
              //     //   return Column(
              //     //     children: [
              //     //       Image(image: AssetImage('assets/food.jpg')),
              //     //       Text('model.selectedthing.userName')
              //     //     ],
              //     //   );
              //     // }),
              //     Center(
              child: Items(),
            )
            // ],
            // ),
            )
        // (children: [Items(), Items()])
        // Container(
        //     child: Column(children: [
        //   Row(children: [
        //     CircleAvatar(child: ImageInput()),
        //     SizedBox(
        //       width: 10.0,
        //     ),
        //     Text(_userName)
        //   ]),
        // ]))
        );
  }
}
