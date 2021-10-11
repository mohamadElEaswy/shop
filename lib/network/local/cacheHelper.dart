import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is bool) {
      await sharedPreferences!.setBool(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  static getData({required String key}){
    sharedPreferences!.get(key);
  }

  static removeData({required String key}){
    sharedPreferences!.remove(key);
  }
}
