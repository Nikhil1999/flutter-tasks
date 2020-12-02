import 'dart:convert';

import 'package:flutter/material.dart';

class ClassModel {
  String _id, _name, _coach, _type, _timing, _color, _imageURL;
  List<String> _userList;

  ClassModel(this._id, this._name, this._coach, this._type, this._timing,
      this._color, this._userList, this._imageURL);

  ClassModel.fromJson(var json) {
    this._id = json['classId'];
    this._name = json['className'];
    this._coach = json['coachName'];
    this._type = json['classType'];
    this._timing = json['classTiming'];
    this._color = json['classColorCode'];
    this._userList = json['signInUserId'].cast<String>();
    this._imageURL = json['classImage'];
  }

  static Future<List<ClassModel>> getClassList(BuildContext context) async {
    var json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString('assets/json/class.json'));
    return (json as List).map((e) => ClassModel.fromJson(e)).toList();
  }

  String get id => _id;
  String get name => _name;
  String get coach => _coach;
  String get type => _type;
  String get timing => _timing;
  String get color => _color;
  List<String> get userList => _userList;
  String get imageURL => _imageURL;
}
