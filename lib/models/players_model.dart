import 'package:flutter/material.dart';

class PlayersModel {
  String? name;
  String? family;
  int? mobilenumber;
  String? group;
  Image? image;

  PlayersModel({
    required this.name,
    required this.family,
    this.mobilenumber,
    this.group,
    this.image,
  });
}
