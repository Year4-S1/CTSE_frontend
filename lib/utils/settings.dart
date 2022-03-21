import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static setSigned(bool signed) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool("signed", signed);
  }

  static Future<bool?> getSigned() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool("signed");
  }

  static setAccessToken(String token) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("access_token", token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("access_token");
  }

  static setUserID(String id) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("user_id", id);
  }

  static Future<String?> getUserID() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("user_id");
  }

  static setUserEmail(String email) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("user_email", email);
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("user_email");
  }
}
