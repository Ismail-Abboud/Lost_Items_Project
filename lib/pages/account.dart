import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';
import '../widgets/image.dart';
import 'profile.dart';

class AccountPage extends StatefulWidget {
  final String image;

  AccountPage(this.image);
  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  final Map<String, dynamic> _formData = {'name': "", 'email': "", 'pass': ''};

  Widget _buildEditUserNameTextField(Thing thing) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        icon: Icon(
          Icons.edit_outlined,
          color: Colors.amberAccent,
        ),
        labelText: isArabic ? 'قم بتعديل اسمك' : 'Edit your Name',
        labelStyle: TextStyle(color: Colors.blueGrey),
      ),
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildEditUserImage(Thing thing) {
    return Container(
        child: Column(children: [
      // CircleAvatar(child: Icon(Icons.camera_alt_outlined)),
      Text(
          isArabic ? ' قم بتعديل صورةالملف الشخصي' : "Edit your profile image"),
      ImageInput(),
      // thing.image = widget.image;
    ]));
  }

  Widget _buildEditPasswordTextField(Thing thing) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          icon: Icon(
            Icons.edit_attributes_rounded,
            color: Colors.blue,
          ),
          labelText: isArabic ? 'قم بتعديل كلمة المرور' : 'Edit your password',
          labelStyle: TextStyle(color: Colors.blueGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
          )),
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  void _saveChanges(Function updateName) {
    updateName(_formData['name']);
    Navigator.pushReplacementNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'حسابي' : 'My account'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            model.selectedthing;
            return ListView(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                _buildEditUserImage(model.selectedthing),
                SizedBox(
                  height: 10.5,
                ),
                _buildEditUserNameTextField(model.selectedthing),
                SizedBox(
                  height: 10.5,
                ),
                _buildEditPasswordTextField(model.selectedthing),
                SizedBox(
                  height: 10.5,
                ),
                Center(
                    child: RaisedButton(
                  onPressed: () => _saveChanges(model.updateName),
                  //Text('saved! ${_formData['name']}');

                  // icon: Icon(Icons),
                  child: Text(isArabic ? 'حفظ التغييرات' : 'Save Changes'),
                  color: Colors.blue[50],
                ))
              ],
            );
          })),
    );
  }
}
