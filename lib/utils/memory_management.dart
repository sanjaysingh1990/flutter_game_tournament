import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPrefsKeys.dart';

class MemoryManagement {
  static SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static void setLoginStatus({@required bool status}) {
    prefs.setBool(SharedPrefsKeys.IS_USER_SIGNED_IN, status);
  }

  static bool getLoginStatus() {
    return prefs.getBool(SharedPrefsKeys.IS_USER_SIGNED_IN);
  }

  //Theme module
  static void changeTheme(bool value) {
    prefs.setBool(SharedPrefsKeys.is_dark_mode, value);
  }

  static bool get isDarkMode {
    return prefs.getBool(SharedPrefsKeys.is_dark_mode) ?? false;
  }

  //Locale module
  static String get appLocale {
    return prefs.getString(SharedPrefsKeys.language_code) ?? null;
  }

  static void changeLanguage(String value) {
    prefs.setString(SharedPrefsKeys.language_code, value);
  }

}
