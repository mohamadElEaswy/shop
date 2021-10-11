import 'package:flutter/material.dart';
import 'package:shop/constants/consts.dart';
import 'package:shop/layout/login/login.dart';
import 'package:shop/network/local/cacheHelper.dart';

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndRemove(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) =>
        false, //anonymous method to delete previous routes
  );
}

void logOut(context) {
  CacheHelper.sharedPreferences!
    .setString('token', '');
  CacheHelper.sharedPreferences!.clear();

  token = '';
  navigateAndRemove(context, LoginScreen());
}
