import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String password;
  final String name;

  User({
    @required this.id,
    this.email = "user@gmail.com",
    @required this.password,
    @required this.name,
  });
}
