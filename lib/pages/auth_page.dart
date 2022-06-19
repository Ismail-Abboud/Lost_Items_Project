// import 'dart:html';

import 'package:flutter/material.dart';
import '../scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:another_flushbar/flushbar.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

bool isArabic = false;

class AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  bool _acceptterms = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passConfirmController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  var _icon = Icon(
    Icons.visibility_off,
    color: Colors.blue,
  );
  bool _textForm = true;
  var _icon2 = Icon(Icons.visibility_off, color: Colors.blue);
  bool _textForm2 = true;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.grey.withOpacity(0.5),
          BlendMode.dstATop,
        ));
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: isArabic ? "اسم المستخدم" : 'User Name',
          filled: true,
          icon: Icon(
            Icons.account_box,
            size: 30,
            color: Colors.blue,
          ),
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty)
            return isArabic
                ? " الأسم يتكون فقط من الأحرف"
                : 'The name consists only of characters';
        },
        onSaved: (String value) {
          _formData['name'] = value;
        });
  }

  Widget _buildUserEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: isArabic ? " بريد إلكتروني" : 'E_Mail',
        filled: true,
        icon: Icon(
          Icons.email,
          size: 30,
          color: Colors.blue,
        ),
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        helperStyle: TextStyle(fontSize: 15),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) return isArabic ? "*مطلوب" : '* Required';
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return isArabic
              ? "أدخل بريد إلكتروني صحيح من فضلك"
              : 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passConfirmController,
      decoration: InputDecoration(
        labelText: isArabic ? "كلمة المرور" : 'Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
        filled: true,
        icon: Icon(
          Icons.lock,
          size: 30,
          color: Colors.blue,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _textForm = !_textForm;
              _icon = _textForm
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    );
            });
          },
          icon: _icon,
        ),
        fillColor: Colors.white,
        helperStyle: TextStyle(fontSize: 20),
      ),
      obscureText: _textForm,
      validator: (String value) {
        if (value.isEmpty || value.length < 8)
          return isArabic ? "كلمة المرورغير مقبولة" : 'Password  Invaild';
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
        filled: true,
        icon: Icon(
          Icons.task_alt,
          size: 30,
          color: Colors.blue,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _textForm2 = !_textForm2;
              _icon2 = _textForm2
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    );
            });
          },
          icon: _icon2,
        ),
        fillColor: Colors.white,
        helperStyle: TextStyle(fontSize: 20),
      ),
      obscureText: _textForm2,
      validator: (String value) {
        if (_passConfirmController.text != value)
          return isArabic ? "كلمة المرور غير متطابقة" : 'Passwords not match';
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildLangugetSwitch() {
    return SwitchListTile(
      activeColor: Colors.blue,
      value: isArabic,
      onChanged: (bool value) {
        setState(() {
          isArabic = value;
        });
      },
      title: Text(
        isArabic == true ? 'لغة عربية' : 'English Languge',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void setData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('username', _formData['name']);
    _pref.setString('email', _formData['email']);
    _pref.setString('password', _formData['password']);
    _pref.setBool('languge', isArabic);
  }

  void _submitForm(Function login) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
    login(_formData['email'], _formData['password'], _formData['name']);
    Navigator.pushReplacementNamed(context, '/home');
    setData();

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
        isArabic ?'تم التسجيل الدخول بنجاح':
        'Successful LogIn',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).show(context);*/
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
            child: Text(isArabic ? "إنشاء مستخدم" : 'Authentication Page')),
      ),
      body: Container(
        padding: EdgeInsets.all(10.5),
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    _buildUserNameTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildUserEmailTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildLangugetSwitch(),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                        child: Text(isArabic
                            ? ' ${_authMode == AuthMode.Login ? 'إنشاء حساب' : 'تسجيل دخول'}'
                            : 'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}')),
                    SizedBox(
                      height: 10,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text(isArabic ? "تسجيل الدخول" : 'LOGIN'),
                          onPressed: () => _submitForm(model.login),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
