import 'dart:convert';

import 'package:flutter/material.dart';

class PlayersModel {
  String? name;
  String? family;
  String? mobilenumber;
  String? group;
  Image? image;

  PlayersModel({
    required this.name,
    //dosent need for this moment
    this.family,
    required this.mobilenumber,
    required this.group,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'mobilenumber': mobilenumber, 'group': group};
  }

  PlayersModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mobilenumber = json['mobilenumber'],
        group = json['group'];
}
