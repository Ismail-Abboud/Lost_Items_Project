import 'package:flutter/material.dart';
import 'package:project1/mytheme.dart';
import 'package:project1/pages/profile.dart';
import 'pages/account.dart';
import 'pages/messages.dart';
import 'scoped_model/main.dart';
import 'pages/myConfirms_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/profile.dart';
import 'pages/auth_page.dart';
import 'pages/home.dart';
import 'pages/add_page.dart';
import 'pages/item.dart';
import 'pages/confirmItems_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int thingindex;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: MainModel(),
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.amber[100],
            accentColor: Colors.amber[200],
            buttonColor: Colors.amber[500],
          ),
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/auth': (BuildContext context) => AuthPage(),
            '/home': (BuildContext context) => HomePage(),
            '/messages': (BuildContext context) => MessagesPage(null),
            '/add': (BuildContext context) => AddPage(""),
            '/account': (BuildContext context) => AccountPage(""),
            '/myConfirms': (BuildContext context) => myConfirmsList(null),
            '/profile': (BuildContext context) => ProfilePage(""),
            '/items': (BuildContext context) => ConfirmItemList(null),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'thing') {
              final int index = int.parse(pathElements[2]);
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ThingPage(index),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            );
          },
        ));
  }
}
