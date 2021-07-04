import "package:shared_preferences/shared_preferences.dart";

class UserSettings {
  static final UserSettings _instance = new UserSettings._internal();

  factory UserSettings() {
    return _instance;
  }
  UserSettings._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String? get token {
    return _prefs.getString('token');
  }

  set token(String? value) {
    _prefs.setString('token', value!);
  }

  String? get userId {
    return _prefs.getString('userId');
  }

  set userId(String? value) {
    _prefs.setString('userId', value!);
  }
}
