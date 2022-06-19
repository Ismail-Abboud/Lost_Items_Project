// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proj4dart/proj4dart.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../pages/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home.dart';
//import 'package:another_flushbar/flushbar.dart';

void _deleteData() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.remove("username");
  _pref.remove("email");
  _pref.remove("password");
  _pref.remove("languge");
}

_showDialogAlert(context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.WARNING,
    body: Center(
      child: Text(
        isArabic ? '!ستقوم بتسجيل الخروج' : 'You Will Log Out!',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnCancelOnPress: () {},
    btnCancelText: isArabic ? 'تراجع' : 'Cancel',
    btnOkText: isArabic ? " متابعة" : " Countinue",
    btnOkOnPress: () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
      _deleteData();

      /*
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.done,
        size: 40,
        color: Colors.green,
      ),
      backgroundColor: Colors.white,
      messageText: Text(
        isArabic ?'تم التسجيل الخروج بنجاح':
        'Successful LogIn',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).show(context);*/
    },
  )..show();
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(children: [
      AppBar(
        leading: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        title: Text(isArabic ? 'خيارات' : 'Options'),
      ),
      ListTile(
        leading: Icon(Icons.account_circle),
        title: Text(isArabic ? 'ملفي الشخصي' : 'My Profile'),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.add),
        title: Text(isArabic
            ? 'أنشر ما فقدت أو ما وجدت'
            : 'Post What you Lost or Found'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/add');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.question_answer),
        title: Text(isArabic ? 'تأكيد الطلبات' : 'Confirm requests'),
        onTap: () {
          Navigator.pushNamed(context, '/myConfirms');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.home),
        title: Text(isArabic ? 'الصفحة الرئيسية' : 'Home'),
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text(isArabic ? 'تسجيل الخروج' : 'LogOut'),
        onTap: () => _showDialogAlert(context),
      ),
      Divider(),
    ]),
  );
}
