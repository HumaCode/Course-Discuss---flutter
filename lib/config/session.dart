import 'dart:convert';

import 'package:course_discuss/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<User?> getUser() async {
    User? currentUser;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');

    // dicek jika tidak null
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      currentUser = User.fromJson(mapUser);
    }

    // jika kosong ya null
    return currentUser;
  }

  // set session
  static Future<bool> setUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    return await pref.setString('user', stringUser);
  }

  // menghapus session
  static Future<bool> clearUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.remove('user');
  }
}
