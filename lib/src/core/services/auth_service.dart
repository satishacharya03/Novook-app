import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/domain/user.dart';

part 'auth_service.g.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';
  
  final SharedPreferences _prefs;
  
  AuthService(this._prefs);
  
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }
  
  String? getToken() {
    return _prefs.getString(_tokenKey);
  }
  
  Future<void> saveUser(User user) async {
    await _prefs.setString(_userKey, userToJson(user));
  }
  
  User? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return userFromJson(userJson);
    }
    return null;
  }
  
  Future<void> clearAuth() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }
  
  bool get isLoggedIn => getToken() != null;
  
  String userToJson(User user) {
    return '{"id":"${user.id}","name":"${user.name}","username":"${user.username}","email":"${user.email}","image":"${user.image ?? ''}","role":"${user.role}"}';
  }
  
  User userFromJson(String json) {
    // Simple JSON parsing for stored user
    final Map<String, dynamic> map = {};
    final content = json.substring(1, json.length - 1);
    final pairs = content.split('","');
    for (final pair in pairs) {
      final parts = pair.replaceAll('"', '').split(':');
      if (parts.length >= 2) {
        map[parts[0]] = parts.sublist(1).join(':');
      }
    }
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      image: map['image']?.isEmpty == true ? null : map['image'],
      role: map['role'] ?? 'USER',
    );
  }
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
Future<AuthService> authService(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return AuthService(prefs);
}
