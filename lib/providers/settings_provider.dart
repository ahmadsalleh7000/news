import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isArabic = false;
  bool _isAppLockEnabled = false;
  String _appLockType = 'None'; // Possible values: 'None', 'Fingerprint', 'PIN', 'Pattern'
  String? _encryptedPattern; // Encrypted pattern
  String? _iv; // Initialization vector

  bool get isDarkMode => _isDarkMode;
  bool get isArabic => _isArabic;
  bool get isAppLockEnabled => _isAppLockEnabled;
  String get appLockType => _appLockType;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isArabic = prefs.getBool('isArabic') ?? false;
    _isAppLockEnabled = prefs.getBool('isAppLockEnabled') ?? false;
    _appLockType = prefs.getString('appLockType') ?? 'None';
    _encryptedPattern = prefs.getString('encryptedPattern');
    _iv = prefs.getString('iv');
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setArabic(bool value) async {
    _isArabic = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isArabic', value);
    notifyListeners();
  }

  Future<void> setAppLockEnabled(bool value) async {
    _isAppLockEnabled = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAppLockEnabled', value);
    notifyListeners();
  }

  Future<void> setAppLockType(String type) async {
    _appLockType = type;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLockType', type);
    notifyListeners();
  }

  Future<void> setPattern(String pattern) async {
    final key = encrypt.Key.fromUtf8('32characterlongkeyfor256bit'); // 256-bit key
    final iv = encrypt.IV.fromLength(16); // Generate a random IV
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    _encryptedPattern = encrypter.encrypt(pattern, iv: iv).base64;
    _iv = iv.base64; // Store IV in base64 format
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('encryptedPattern', _encryptedPattern!);
    await prefs.setString('iv', _iv!);
    notifyListeners();
  }

  Future<bool> validatePattern(String pattern) async {
    if (_encryptedPattern == null || _iv == null) {
      return false;
    }

    final key = encrypt.Key.fromUtf8('32characterlongkeyfor256bit'); // 256-bit key
    final iv = encrypt.IV.fromBase64(_iv!); // Use the stored IV
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decryptedPattern = encrypter.decrypt64(_encryptedPattern!, iv: iv);
    return pattern == decryptedPattern;
  }
}
