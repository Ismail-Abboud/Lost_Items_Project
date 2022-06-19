import 'package:flutter/material.dart';

class Thing {
  final String title;
  final String date;
  final String description;
  final String number;
  final String time;
  final String image;
  final String status;
  final String location;
  final String userEmail;
  final String userId;
  final String userName;
  final bool isFavorite;
  final bool confirmed;
  int responsed;
  String confirmImage;
  String confirmMoney;
  String confirmDescription;

  Thing(
      {@required this.title,
      @required this.date,
      @required this.description,
      @required this.number,
      @required this.time,
      @required this.image,
      @required this.status,
      @required this.location,
      @required this.userEmail,
      @required this.userId,
      @required this.userName,
      this.isFavorite = false,
      this.confirmed = false,
      this.responsed = -1,
      this.confirmImage,
      this.confirmMoney,
      this.confirmDescription});
}
