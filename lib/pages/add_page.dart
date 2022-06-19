import 'package:flutter/material.dart';
import 'package:project1/pages/auth_page.dart';
import 'package:project1/pages/thing_list.dart';
import '../widgets/bottombar.dart';
import '../widgets/image.dart';
import '../widgets/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import '../scoped_model/things.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';
import '../scoped_model/main.dart';
import '../widgets/helpers/13.1 ensure_visible.dart.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  final String image;
  AddPage(this.image);
  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  int _selectedindex = 2;
  final Map<String, dynamic> _formData = {
    'title': "",
    'description': "",
    'status': "lost",
    'image': 'assets/question.png',
    'date': " ",
    'location': "d",
    // 'userEmail': "d",
    // 'userId': "d",
    'number': "",
    'time': ""
  };

  DateTime _date = DateTime.now();
  String _formatdate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final _nameTextController = TextEditingController();
  final _descTextController = TextEditingController();

  void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  Widget _buildNameTextField(Thing thing) {
    if (thing == null && _nameTextController.text.trim() == '')
      _nameTextController.text = '';
    else if (thing != null && _nameTextController.text.trim() == '')
      _nameTextController.text = thing.title;
    else if (_nameTextController.text.trim() != '')
      _nameTextController.text = _nameTextController.text;
    else
      _nameTextController.text = '';

    return EnsureVisibleWhenFocused(
      focusNode: _nameFocusNode,
      child: TextFormField(
        controller: _nameTextController,
        focusNode: _nameFocusNode,
        decoration: InputDecoration(
          icon: Icon(
            Icons.question_mark_sharp,
            color: Colors.amber,
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: isArabic ? 'نوع الغرض' : 'Item type is:',
          labelStyle: TextStyle(color: Colors.grey),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return isArabic ? 'اسم الغرض مطلوب*' : 'item name is required';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildStatusTextField(Thing thing) {
    return EnsureVisibleWhenFocused(
      focusNode: _statusFocusNode,
      child: TextFormField(
        focusNode: _statusFocusNode,
        decoration: InputDecoration(
          icon: Icon(
            Icons.title,
            color: Colors.amber,
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: isArabic ? 'مفقود/موجود' : 'found/lost:',
          labelStyle: TextStyle(color: Colors.grey),
        ),
        initialValue: thing == null ? '' : thing.status,
        validator: (String value) {
          if (value.isEmpty ||
              (value != 'found' && value != 'lost') ||
              (value != 'مفقود' && value != 'موجود')) {
            return isArabic ? 'مفقود أم موجود؟' : 'found or lost?';
          }
        },
        onSaved: (String value) {
          if (value == 'موجود')
            value = 'found';
          else if (value == 'مفقود') value = 'lost';
          _formData['status'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Thing thing) {
    if (thing == null && _descTextController.text.trim() == '')
      _descTextController.text = '';
    else if (thing != null && _descTextController.text.trim() == '')
      _descTextController.text = thing.description;

    return EnsureVisibleWhenFocused(
        focusNode: _descFocusNode,
        child: TextFormField(
          controller: _descTextController,
          focusNode: _descFocusNode,
          maxLines: 2,
          decoration: InputDecoration(
            icon: Icon(
              Icons.list_alt,
              color: Colors.amber,
            ),
            labelText: isArabic
                ? 'تفاصيل،أي تفاصيل إضافية ترغب بإضافتها؟'
                : 'description, is there any additional description you can add ?',
            labelStyle: TextStyle(color: Colors.grey),
          ),
          validator: (String value) {
            if (value.isEmpty || value.length < 5) {
              return isArabic
                  ? 'أي تفصيل يمكن أن يساعد'
                  : 'any detail may help';
            }
          },
          onSaved: (String value) {
            _formData['description'] = value;
          },
        ));
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _date = value;
        _formatdate = DateFormat('yyyy-MM-dd').format(_date);
        _formData['date'] = _formatdate;
      });
    });
  }

  final _dateTextController = TextEditingController();
  Widget _buildDateTextField(Thing thing) {
    if (thing == null && _dateTextController.text.trim() == '')
      _dateTextController.text = '';
    else if (thing != null && _dateTextController.text.trim() == '')
      _dateTextController.text = thing.date;

    return EnsureVisibleWhenFocused(
        focusNode: _dateFocusNode,
        child: Row(textBaseline: TextBaseline.ideographic, children: [
          Icon(
            Icons.date_range,
            color: Colors.amber[500],
          ),
          SizedBox(
            width: 10.5,
          ),
          InkWell(
            child: Text(
              'Set relative time  ${_formData['date']}',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () => _showDatePicker(context),
          ),
        ]));
  }

  final _phoneTextController = TextEditingController();
  Widget _buildPhoneNumberTextField(Thing thing) {
    if (thing == null && _phoneTextController.text.trim() == '')
      _phoneTextController.text = '';
    else if (thing != null && _phoneTextController.text.trim() == '')
      _phoneTextController.text = thing.number;

    return EnsureVisibleWhenFocused(
        focusNode: _phoneFocusNode,
        child: TextFormField(
          focusNode: _phoneFocusNode,
          controller: _phoneTextController,
          decoration: InputDecoration(
            filled: true,
            icon: Icon(
              Icons.phone,
              color: Colors.amberAccent,
            ),
            labelText:
                isArabic ? 'أدخل رقمك للتواصل' : 'Enter number to contact',
            labelStyle: TextStyle(color: Colors.black),
          ),
          keyboardType: TextInputType.text,
          onSaved: (String value) {
            _formData['number'] = value;
          },
        ));
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  void _showTimePicker(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    TimeOfDay newTime =
        await showTimePicker(context: context, initialTime: time);
    if (newTime != null) {
      setState(() {
        time = newTime;
        String _formattime = formatTimeOfDay(time);
        _formData['time'] = _formattime;
      });
    }
  }

  final _timeTextController = TextEditingController();
  Widget _buildTimeTextField(Thing thing) {
    if (thing == null && _timeTextController.text.trim() == '')
      _timeTextController.text = '';
    else if (thing != null && _timeTextController.text.trim() == '')
      _timeTextController.text = thing.time;

    return EnsureVisibleWhenFocused(
        focusNode: _timeFocusNode,
        child: Row(textBaseline: TextBaseline.ideographic, children: [
          Icon(
            Icons.timer_outlined,
            color: Colors.amber[500],
          ),
          SizedBox(
            width: 10.5,
          ),
          InkWell(
            child: Text(
              'Set relative time  ${_formData['time']}',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () => _showTimePicker(context),
          ),
        ]));
  }

  final _locationTextController = TextEditingController();
  Widget _buildLocationTextField(Thing thing) {
    if (thing == null && _locationTextController.text.trim() == '')
      _locationTextController.text = '';
    else if (thing != null && _locationTextController.text.trim() == '')
      _locationTextController.text = thing.location;

    return EnsureVisibleWhenFocused(
        focusNode: _locationFocusNode,
        child: TextFormField(
          controller: _locationTextController,
          focusNode: _locationFocusNode,
          decoration: InputDecoration(
              labelText: isArabic ? "قم بتحديد الموقع" : 'Set the location',
              labelStyle: TextStyle(color: Colors.grey),
              icon: Icon(
                Icons.location_on,
                color: Colors.amberAccent,
              )),
          validator: (String value) {
            if (value.isEmpty) {
              return isArabic ? "مطلوب*" : '*Required ';
            }
          },
          onSaved: (String value) {
            _formData['location'] = value;
          },
        ));
  }

  void _submitForm(
      Function addThing, Function updateThing, Function setSelectedThing,
      [int selectedThingIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    _formData['image'] = widget.image;
    if (selectedThingIndex == null) {
      addThing(
          _nameTextController.text,
          _descTextController.text,
          _dateTextController.text,
          _phoneTextController.text,
          _locationTextController.text,
          _timeTextController.text,
          _formData['image'],
          _formData['status']);

      Navigator.pushReplacementNamed(context, '/home').then((_) => {
            setSelectedThing(null),
          });
    } else {
      updateThing(
          _nameTextController.text,
          _descTextController.text,
          _formData['date'],
          _formData['number'],
          _formData['location'],
          _formData['time'],
          _formData['image'],
          _formData['status']);
    }

    Navigator.pushNamed(context, '/home').then((_) => setSelectedThing(null));
  }

  Widget _addItem(BuildContext context, Thing thing) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Form(
              key: _formKey,
              child: ListView(padding: EdgeInsets.all(10.0), children: [
                ImageInput(),
                SizedBox(
                  height: 10.0,
                ),
                _buildTimeTextField(thing),
                SizedBox(height: 20.5),
                _buildStatusTextField(thing),
                SizedBox(height: 10.0),
                _buildDescriptionTextField(thing),
                SizedBox(height: 10.0),
                _buildNameTextField(thing),
                SizedBox(height: 10.0),
                // _buildLocationTextField(thing),
                // LocationInput(),
                _buildLocationTextField(thing),
                SizedBox(height: 10.0),
                _buildDateTextField(thing),
                SizedBox(height: 20.5),
                _buildPhoneNumberTextField(thing),
                SizedBox(height: 10.5),
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                      child: Text(isArabic ? 'حفظ' : 'Save'),
                      textColor: Colors.white,
                      onPressed: () => {
                            _submitForm(model.addThing, model.updateThing,
                                model.selectThing, model.selectedThingIndex),
                          });
                }),
              ]),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(isArabic ? "إدارة أغراضي" : "Manage Items"),
              bottom: TabBar(tabs: [
                Tab(
                    text: isArabic ? 'إضافة عنصر' : 'Add Item',
                    icon: Icon(Icons.add)),
                Tab(
                    text: isArabic ? 'منشوراتي' : 'My posts',
                    icon: Icon(Icons.list)),
              ]),
            ),
            body: TabBarView(children: [
              _addItem(context, model.selectedthing),
              ThingList()
            ]),
            bottomNavigationBar: buildBottomNavigator(context, _selectedindex),
          ));
    });
  }
}
