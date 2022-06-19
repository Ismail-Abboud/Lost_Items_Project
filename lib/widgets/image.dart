import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:project1/pages/account.dart';
import 'package:project1/pages/add_page.dart';
import 'dart:async';
import '../pages/add_page.dart';
import '././../pages/auth_page.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().getImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
      Navigator.pop(context);
      AddPage(image.path);
      AccountPage(image.path);
    });
  }

  void _openImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 220.0,
              padding: EdgeInsets.all(60.0),
              child: Column(
                children: [
                  Text(
                    isArabic ? 'إختر صورة العنصر' : "Pick an image of the Item",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Row(children: [
                            Icon(Icons.image_outlined),
                            Text(isArabic ? "استخدم المعرض" : "use gallery",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                )),
                          ])),
                      FlatButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Row(children: [
                            Icon(Icons.camera_alt_outlined),
                            Text(isArabic ? "استخدم الكاميرا" : "use camera",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                )),
                          ])),
                    ],
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Colors.orange[200];
    return Container(
        margin: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            OutlineButton(
              onPressed: _openImagePicker,
              borderSide: BorderSide(color: buttonColor, width: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: buttonColor,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    isArabic ? "أضف صورة" : "Add Image",
                    style: TextStyle(color: buttonColor),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            image == null
                ? Text(
                    isArabic
                        ? "قم بإختيار صورة من فضلك"
                        : "please pick an image",
                    style: TextStyle(color: Colors.redAccent))
                : Image.file(image,
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter),
          ],
        ));
  }
}
