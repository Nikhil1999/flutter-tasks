import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  static const String _user = 'User';

  var _json;
  String _id, _name, _email, _imageURL;

  UserModel(this._id, this._name, this._email, this._imageURL);

  UserModel.fromJson(var json) {
    this._json = json;
    this._id = json['userId'].toString();
    this._name = json['userName'];
    this._email = json['email'];
    this._imageURL = json['profilePic'];
  }

  Future<void> set() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_user, jsonEncode(_json));
  }

  static Future<UserModel> get() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      String json = preferences.getString(_user);
      if (json != null) {
        return UserModel.fromJson(jsonDecode(json));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> clear() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<List<UserModel>> getUserList(BuildContext context) async {
    var json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString('assets/json/user.json'));
    return (json as List).map((e) => UserModel.fromJson(e)).toList();
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get imageURL => _imageURL;
}
