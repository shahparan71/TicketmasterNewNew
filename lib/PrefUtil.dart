import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static SharedPreferences? preferences;
  static bool _init = false;

  static Future init() async {
    if (_init) return;
    preferences = await SharedPreferences.getInstance();
    _init = true;
    return preferences;
  }
}
