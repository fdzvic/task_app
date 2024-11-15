import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final SharedPreferences sharedPreferences;

  AppStorage({required this.sharedPreferences});

  // Save data
  Future<void> saveData(String key, dynamic data) async {
    final jsonString = json.encode(data);
    await sharedPreferences.setString(key, jsonString);
  }

  // get data
  dynamic getData(String key) {
    final jsonString = sharedPreferences.getString(key);
    return jsonString != null ? json.decode(jsonString) : null;
  }

  // get List data
  List<dynamic>? getListData(String key) {
    final jsonString = sharedPreferences.getString(key);
    return jsonString != null ? json.decode(jsonString) as List<dynamic> : null;
  }

  // delete data
  Future<void> removeData(String key) async {
    await sharedPreferences.remove(key);
  }

  // clean all data
  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }
}
