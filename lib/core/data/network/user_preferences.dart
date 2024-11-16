import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal() {
    initPrefs();
  }

  late SharedPreferences _prefs;

  Future<SharedPreferences> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  // GET y SET datos de usuario
  String get userData {
    return _prefs.getString('userData') ?? '';
  }

  set userData(String value) {
    _prefs.setString('userData', value);
  }
}

final UserPreferences prefs = UserPreferences();
