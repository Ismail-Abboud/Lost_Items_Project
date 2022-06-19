import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../scoped_model/main.dart';
import '../scoped_model/things.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';
import '../widgets/items/items.dart';
import '../models/thing.dart';
import 'confirm.dart';
import 'auth_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}
/*
bool isDarkMode = false;
Icon _switchThemIcon = Icon(
  Icons.sunny,
  color: Colors.white,
);*/

class HomePageState extends State<HomePage> {
  int _selectedindex = 1;
  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = isArabic ? 'الصفحة الرئيسية' : "Home Page";
    return MaterialApp(
        home: Scaffold(
      body: DefaultTabController(
          length: 2,
          child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Scaffold(
                drawer: buildDrawer(context),
                appBar: AppBar(
                  actions: [
                    /*
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                          _switchThemIcon = isDarkMode == true
                              ? Icon(
                                  Icons.dark_mode,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.sunny,
                                  color: Colors.yellow,
                                );
                        });
                      },
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.black,
                    ),
                    _switchThemIcon*/
                  ],
                  brightness: Brightness.dark,
                  title: Center(
                    child: Text(
                      title,
                    ),
                  ),
                ),
                body: Container(child: Items()),
                floatingActionButton: SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: Colors.amber,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.4,
                  children: [
                    SpeedDialChild(
                      label: isArabic ? 'المفضلة' : "Favorite",
                      child: IconButton(
                        icon: Icon(
                          model.displayFavoritesOnly
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          model.toggleDisplayMode();
                        },
                      ),
                    ),
                    SpeedDialChild(
                      label: isArabic ? "مفقودات" : "Lost",
                      child: IconButton(
                        icon: Icon(
                          Icons.search_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          model.toggleStatusDisplayMode(1);
                          title = isArabic ? "مفقودات" : "Lost";
                        },
                      ),
                    ),
                    SpeedDialChild(
                      label: isArabic ? "موجودات" : "Fond",
                      child: IconButton(
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          model.toggleStatusDisplayMode(0);
                          title = isArabic ? "موجودات" : "Fond";
                        },
                      ),
                    ),
                    SpeedDialChild(
                      label: isArabic ? "الصفحة الرئيسية" : "Home Page",
                      child: IconButton(
                        icon: Icon(
                          Icons.home_rounded,
                        ),
                        onPressed: () {
                          model.toggleStatusDisplayMode(-1);
                          title = isArabic ? "الصفحة الرئيسية" : "Home Page";
                        },
                      ),
                    )
                  ],
                ),
                bottomNavigationBar:
                    buildBottomNavigator(context, _selectedindex));
          })),
    ));
  }
}
