import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/userResponseModel.dart';

class UserUtils {
  static UserInfo userInfo = UserInfo();
  getTokken() async {
    try {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      final tokken = sharedUser.getString('tokken') ?? '';
      return "Bearer $tokken";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getLoggedIn() async {
    try {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      final response = sharedUser.getString('logged') ?? 'no';
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getUser() async {
    try {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      userInfo = UserInfo.fromJson(jsonDecode(sharedUser.getString('user')!));
      return userInfo;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  logoutMe(BuildContext context) async {
    try {
      SharedPreferences shared_User = await SharedPreferences.getInstance();

      await shared_User.remove('user');
      await shared_User.remove('tokken');
      await shared_User.remove('logged');

      return true;
    } catch (e) {
      return false;
    }
  }

  saveUserInfo(UserInfo? userInfo, String tokken) async {
    try {

      userInfo=userInfo;
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      String userString = jsonEncode(userInfo);
      sharedUser.setString('user', userString);
      sharedUser.setString('tokken', tokken);
      sharedUser.setString('logged', "yes");
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  saveMyFirstTime() async {
    try {
      SharedPreferences shared_User = await SharedPreferences.getInstance();

      shared_User.setString('first_time', "done");
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getMyFirstTime() async {
    try {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      final response = shared_User.getString('first_time') ?? "not";
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
