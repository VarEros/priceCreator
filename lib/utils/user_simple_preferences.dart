import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyGananciasRefri = 'gananciasRefri';
  static const _keyGananciasNoRefri = 'gananciasNoRefri';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setGanancias(double gananciasRefri, double gananciasNoRefri) async {
    await _preferences?.setDouble(_keyGananciasRefri, gananciasRefri);
    await _preferences?.setDouble(_keyGananciasNoRefri, gananciasNoRefri);
  }

  static double? getGananciasRefri() => _preferences?.getDouble(_keyGananciasRefri); 
  static double? getGananciasNoRefri() => _preferences?.getDouble(_keyGananciasNoRefri); 
}