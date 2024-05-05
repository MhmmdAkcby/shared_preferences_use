import 'package:shared_preference/shared_not_initilazed.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { action }

class SharedManager {
  SharedPreferences? preferences;

  SharedManager();

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  void _checkPreferences() {
    if (preferences == null) throw SharedNotInitilazed();
  }

  Future<void> saveString(SharedKeys key, String value) async {
    _checkPreferences();
    await preferences?.setString(key.name, value);
  }

  String? getString(SharedKeys key) {
    _checkPreferences();
    return preferences?.getString(key.name);
  }

  Future<bool> remove(SharedKeys key) async {
    return (await preferences?.remove(key.name)) ?? false;
  }
}
