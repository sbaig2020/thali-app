import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _keyName = 'patient_name';
  static const _keyTransfusion = 'transfusion_date';

  static Future<void> saveName(String name) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_keyName, name);
  }

  static Future<String?> getName() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_keyName);
  }

  static Future<void> saveTransfusion(String date) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_keyTransfusion, date);
  }

  static Future<String?> getTransfusion() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_keyTransfusion);
  }
}
